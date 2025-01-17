unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient,
  IdSMTPBase, IdSMTP, IdSSL, IdSSLOpenSSL, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdMessage, Vcl.StdCtrls, IdPOP3, IdIMAP4, Vcl.Mask,
  DBCtrlsEh, Vcl.ExtCtrls,IniFiles;

type
  TfrmMain = class(TForm)
    pnlLogin: TPanel;
    dbehAdminLogin: TDBEditEh;
    dbehAdminPass: TDBEditEh;
    btnSQLLogin: TButton;
    lblSQLStatus: TLabel;
    gbSQL: TGroupBox;
    memoLog: TMemo;
    pnlLogger: TPanel;
    pnlStatus: TPanel;
    lblStatus: TLabel;
    GroupBox1: TGroupBox;
    lblEmailStatus: TLabel;
    btnEmailLogin: TButton;
    dbehEmailLogin: TDBEditEh;
    dbehEmailPass: TDBEditEh;
    GroupBox2: TGroupBox;
    btnGetEmails: TButton;
    btnSendEmails: TButton;
    procedure btnSQLLoginClick(Sender: TObject);
    procedure LogPrint(_S: String);
    procedure btnEmailLoginClick(Sender: TObject);
    procedure StartTimers;
    procedure StopTimers;
    function CheckSQLConnection: Boolean;
    function CheckSMTP: Boolean;
    function CheckIMAP: Boolean;
    procedure Button3Click(Sender: TObject);
    procedure btnSendEmailsClick(Sender: TObject);
    procedure btnGetEmailsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    isSQLLogged: Boolean;
    isEmailLogged: Boolean;
  end;

var
  frmMain: TfrmMain;

implementation

uses uDM;

{$R *.dfm}

procedure TfrmMain.btnEmailLoginClick(Sender: TObject);
begin
  isEmailLogged := False;
  if not(CheckSMTP) then
  begin
    Exit;
  end;
  dm.IdSMTPSend.Disconnect;
  if not(CheckIMAP) then
  begin
    Exit;
  end;
  dm.idIMAPGet.Disconnect;
  lblEmailStatus.Caption := '������ Email: ���������';
  isEmailLogged := True;
  if (isSQLLogged) AND (isEmailLogged) then
  begin
    lblStatus.Caption := '������ �������: ���������';
    LogPrint('������ �������');
    StartTimers;
  end
  else
  begin
    lblStatus.Caption := '������ �������: ��� ����';
  end;
end;

procedure TfrmMain.btnGetEmailsClick(Sender: TObject);
begin
  dm.GetMails;
end;

procedure TfrmMain.btnSendEmailsClick(Sender: TObject);
begin
  dm.SendMails;
end;

procedure TfrmMain.btnSQLLoginClick(Sender: TObject);
begin
  isSQLLogged := False;
  if not(CheckSQLConnection) then
  begin
    Exit;
  end;
  isSQLLogged := True;
  if (isSQLLogged) AND (isEmailLogged) then
  begin
    LogPrint('������ �������');
    StartTimers;
    lblStatus.Caption := '������ �������: ���������';
  end
  else
  begin
    StopTimers;
    lblStatus.Caption := '������ �������: ��� ����';
  end;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  dm.SendMails;
end;

function TfrmMain.CheckIMAP: Boolean;
begin
  Result := False;
  dm.idIMAPGet.Username := Trim(dbehEmailLogin.Text);
  dm.idIMAPGet.Password := Trim(dbehEmailPass.Text);
  try
    dm.idIMAPGet.Connect;
  except
    on e: Exception do
    begin
      LogPrint('������ ����������� � Email IMAP. �������� �������� ��� ������������ ��� ������.');
      lblEmailStatus.Caption := '������ Email: ��� ����';
      lblStatus.Caption := '������ �������: ��� ����';
      StopTimers;
      Exit;
    end;
  end;
  Result := True;
end;

function TfrmMain.CheckSMTP: Boolean;
begin
  Result := False;
  dm.IdSMTPSend.Username := Trim(dbehEmailLogin.Text);
  dm.IdSMTPSend.Password := Trim(dbehEmailPass.Text);
  try
    dm.IdSMTPSend.Connect;
    dm.IdSMTPSend.Authenticate;
  except
    on e: Exception do
    begin
      LogPrint('������ ����������� � Email SMTP. �������� �������� ��� ������������ ��� ������.');
      lblEmailStatus.Caption := '������ Email: ��� ����';
      lblStatus.Caption := '������ �������: ��� ����';
      StopTimers;
      Exit;
    end;
  end;
  Result := True;
end;

function TfrmMain.CheckSQLConnection: Boolean;
begin
  Result := False;
  with DM do
    begin
       conAS.Connected := true;
    end;
  Result := True;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i : integer;
  con_str : string;
  provider,persist_security_info,user_id,password,initial_catalog,data_source : string;
  email_login,email_password : string;
  url,key : string;
  config : TIniFile;
begin
 try
          config := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
         try
           //��
           provider := config.ReadString('DATA_BASE','provider','');
           persist_security_info := config.ReadString('DATA_BASE','persist_security_info','');
           user_id := config.ReadString('DATA_BASE','user_id','');
           password := config.ReadString('DATA_BASE','password','');
           initial_catalog := config.ReadString('DATA_BASE','initial_catalog','');
           data_source := config.ReadString('DATA_BASE','data_source','');
           //email
           email_login := config.ReadString('EMAIL_SERVER','email_login','');
           email_password := config.ReadString('EMAIL_SERVER','email_password','');
         finally
           config.Free;
         end;

          with dm do
            begin
              con_str := 'Provider=SQLOLEDB.1;Password=' + password + ';Persist Security Info=True;User ID=' + user_id + ';Initial Catalog=' + initial_catalog + ';Data Source=' + data_source + ';';
              conAS.ConnectionString := con_str;


             dbehEmailLogin.Text := email_login;
             dbehEmailPass.Text := email_password;
             btnSQLLoginClick(nil);
             btnEmailLoginClick(nil);
             btnSendEmailsClick(nil);
             Application.Terminate;
            end;

 except
    Application.Terminate;
 end;
end;

procedure TfrmMain.LogPrint(_S: String);
begin
  memoLog.Lines.Add(FormatDateTime('dd.mm.yyyy hh:nn:ss', now()) + ' : ' + _S);
end;

procedure TfrmMain.StartTimers;
begin
  dm.tmrGetEmails.Enabled := True;
  dm.tmrGetToSend.Enabled := True;
end;

procedure TfrmMain.StopTimers;
begin
  dm.tmrGetEmails.Enabled := False;
  dm.tmrGetToSend.Enabled := False;
end;

end.
