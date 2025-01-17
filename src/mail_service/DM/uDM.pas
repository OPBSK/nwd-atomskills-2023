unit uDM;

interface

uses
  System.SysUtils, System.Classes, IdSMTPBase, IdSMTP, IdMessage, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdIMAP4, Data.DB, Data.Win.ADODB, Vcl.ExtCtrls, StrUtils,
  IdText, IdMessageBuilder;

type
  Tdm = class(TDataModule)
    idIMAPGet: TIdIMAP4;
    IdSSLGet: TIdSSLIOHandlerSocketOpenSSL;
    IdMessageGet: TIdMessage;
    IdSSLSend: TIdSSLIOHandlerSocketOpenSSL;
    IdMessageSend: TIdMessage;
    IdSMTPSend: TIdSMTP;
    conAS: TADOConnection;
    sp_check_role: TADOStoredProc;
    tmrGetEmails: TTimer;
    tmrGetToSend: TTimer;
    sp_email_send_get: TADOStoredProc;
    sp_email_sended: TADOStoredProc;
    sp_create_claim: TADOStoredProc;
    sp_email_send_status: TADOStoredProc;
    procedure tmrGetToSendTimer(Sender: TObject);
    procedure SendMails;
    procedure MakeClaims(IdMessageGet: TIdMessage);
    procedure SendStatus(IdMessageGet: TIdMessage);
    procedure GetMails;
    procedure tmrGetEmailsTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

uses uMain;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure Tdm.GetMails;
var
  i: Integer;
  SearchInfo: array of TIdIMAP4SearchRec;
  claimsCount: Integer;
begin
  if not(frmMain.CheckSQLConnection) then
  begin
    exit;
  end;
  if not(frmMain.CheckIMAP) then
  begin
    exit;
  end;
  idIMAPGet.SelectMailBox('INBOX');
  SetLength(SearchInfo, 1);
  SearchInfo[0].SearchKey := skUnseen;
  try
    idIMAPGet.SearchMailBox(SearchInfo);
  except

  end;

  if Length(idIMAPGet.MailBox.SearchResult) > 0 then
  begin
    frmMain.LogPrint('�������� �����: ' + Length(idIMAPGet.MailBox.SearchResult)
      .ToString);
    claimsCount := 0;
    for i := 0 to High(idIMAPGet.MailBox.SearchResult) do
    begin
      idIMAPGet.Retrieve(idIMAPGet.MailBox.SearchResult[i], IdMessageGet);
      if ContainsStr(LowerCase(IdMessageGet.Subject), '<status>') then
      begin
        SendStatus(IdMessageGet);
        claimsCount := claimsCount + 1;
      end
      else
      begin
        MakeClaims(IdMessageGet);
        claimsCount := claimsCount + 1;
      end;
    end;
    frmMain.LogPrint('C������ ����� � �����: ' + claimsCount.ToString);
  end
  else
  begin
    frmMain.LogPrint('����� �� ����� ���');
  end;
  idIMAPGet.Disconnect;
end;

procedure Tdm.MakeClaims(IdMessageGet: TIdMessage);
var
  htmlBuilder: TIdMessageBuilderHtml;
begin
  // ������� ������
  sp_create_claim.Close;
  sp_create_claim.Parameters.ParamByName('@user_mail').Value :=
    IdMessageGet.From.Address;
  sp_create_claim.Parameters.ParamByName('@text_message').Value :=
    IdMessageGet.Body.Text;
  sp_create_claim.Parameters.ParamByName('@header_message').Value :=
    IdMessageGet.Subject;
  try
    sp_create_claim.ExecProc;
  except

  end;
  if not(frmMain.CheckSMTP) then
  begin
    exit;
  end;
  htmlBuilder := TIdMessageBuilderHtml.Create;
  htmlBuilder.Html.Add('<html>');
 // htmlBuilder.Html.Add('<body>');
//  htmlBuilder.Html.Add('<p>�������, ' + LeftStr(IdMessageGet.From.Address,
//    Pos('@', IdMessageGet.From.Address) - 1) + ' ���� ������ � ' +
 //   IntToStr(sp_create_claim.Parameters.ParamByName('@status').Value) +
 //   ' �������. ����������� ����� ' + LeftStr(IdMessageGet.From.Address,
 //   Pos('@', IdMessageGet.From.Address) - 1) +
 //   ', ����� �������������� � ���������� � ����������� ������.</p>');
 // htmlBuilder.Html.Add
 //   ('����� �������� ������ ��������� ������ �� ������ <a href="mailto:techlifeas@gmail.com?subject=<status>">�������� ������</a>');
  htmlBuilder.Html.Add('<body>');
  htmlBuilder.Html.Add('</html>');
  IdMessageSend := htmlBuilder.NewMessage(nil);
  IdMessageSend.From.Text := frmMain.dbehEmailLogin.Text;
  IdMessageSend.Recipients.EMailAddresses := IdMessageGet.From.Address;
  IdMessageSend.Subject := '������ �������';
  try
    IdSMTPSend.Send(IdMessageSend);
  except

  end;
  IdSMTPSend.Disconnect;
end;

procedure Tdm.SendMails;
var
  i: Integer;
  emailsCount: Integer;
  textPart: TIdText;
  htmlBuilder: TIdMessageBuilderHtml;
begin
  sp_email_send_get.Close;
  try
    sp_email_send_get.Open;
  except
    frmMain.LogPrint('������ ��������� ����� � ������� ���� ������');
    exit;
  end;
  conAS.Connected := False;
  if not(conAS.Connected) then
  begin
    if not(frmMain.CheckSQLConnection) then
    begin
      exit;
    end;
  end;
  sp_email_send_get.Close;
  try
    sp_email_send_get.Open;
  except

  end;
  if not(sp_email_send_get.IsEmpty) then
  begin
    frmMain.btnSQLLogin.Enabled := False;
    frmMain.btnEmailLogin.Enabled := False;
    if not(frmMain.CheckSMTP) then
    begin
      exit;
    end;
    emailsCount := 0;
    for i := 0 to sp_email_send_get.RecordCount - 1 do
    begin
      htmlBuilder := TIdMessageBuilderHtml.Create;
      htmlBuilder.Html.Add('<html>');
      htmlBuilder.Html.Add('<body>');
      htmlBuilder.Html.Add('<p>' + sp_email_send_get.FieldByName('text_message')
        .AsString + '</p>');
     // htmlBuilder.Html.Add
     //   ('����� �������� ������ ��������� ������ �� ������ <a href="mailto:techlifeas@gmail.com?subject=<status>">�������� ������</a>');
      htmlBuilder.Html.Add('<body>');
      htmlBuilder.Html.Add('</html>');
      IdMessageSend := htmlBuilder.NewMessage(nil);
      IdMessageSend.From.Text := frmMain.dbehEmailLogin.Text;
      IdMessageSend.Recipients.EMailAddresses := sp_email_send_get.FieldByName
        ('email').AsString;
      IdMessageSend.Subject := sp_email_send_get.FieldByName
        ('header_message').AsString;
      try
        IdSMTPSend.Send(IdMessageSend);
      except

      end;
      emailsCount := emailsCount + 1;
      sp_email_sended.Close;
      sp_email_sended.Parameters.ParamByName('@id_claim_message').Value :=
      sp_email_send_get.FieldByName('id_claim_message').Value;
      sp_email_sended.ExecProc;
      sp_email_send_get.Next;
    end;
    IdSMTPSend.Disconnect;
    frmMain.LogPrint('���������� �����: ' + emailsCount.ToString);
  end
  else
  begin
    frmMain.LogPrint('����� ��� �������� ���');
  end;

end;

procedure Tdm.SendStatus(IdMessageGet: TIdMessage);
var
  htmlBuilder: TIdMessageBuilderHtml;
  i: Integer;
  emailsCount: Integer;
begin

  // ������� ������ �� ���������
  sp_email_send_status.Close;
  sp_email_send_status.Parameters.ParamByName('@login').Value :=
    LeftStr(IdMessageGet.From.Address, Pos('@', IdMessageGet.From.Address) - 1);
  sp_email_send_status.Open;
  if not(sp_email_send_status.IsEmpty) then
  begin
    if not(frmMain.CheckSMTP) then
    begin
      exit;
    end;
    htmlBuilder := TIdMessageBuilderHtml.Create;
    htmlBuilder.Html.Add('<html>');
    htmlBuilder.Html.Add('<body>');
    emailsCount := 0;
    for i := 0 to sp_email_send_status.RecordCount - 1 do
    begin
      htmlBuilder.Html.Add('<p>������ � ' + sp_email_send_status.FieldByName
        ('id_claim').AsString + ' ������ ������: ' +
        sp_email_send_status.FieldByName('caption_state').AsString + '</p>');
      sp_email_send_status.Next;
      emailsCount := emailsCount + 1;
    end;
    htmlBuilder.Html.Add
      ('����� �������� ������ ��������� ������ �� ������ <a href="mailto:techlifeas@gmail.com?subject=<status>">�������� ������</a>');
    htmlBuilder.Html.Add('<body>');
    htmlBuilder.Html.Add('</html>');

    IdMessageSend := htmlBuilder.NewMessage(nil);
    IdMessageSend.From.Text := frmMain.dbehEmailLogin.Text;
    IdMessageSend.Recipients.EMailAddresses := IdMessageGet.From.Address;
    IdMessageSend.Subject := '������ ������';
    try
      IdSMTPSend.Send(IdMessageSend);
    except

    end;
    frmMain.LogPrint('���������� �����: ' + emailsCount.ToString);
    IdSMTPSend.Disconnect;
  end
  else
  begin
    frmMain.LogPrint('��� ����� ��� ��������');
  end;
end;

procedure Tdm.tmrGetEmailsTimer(Sender: TObject);
begin
  GetMails;
end;

procedure Tdm.tmrGetToSendTimer(Sender: TObject);
begin
  SendMails;
end;

end.
