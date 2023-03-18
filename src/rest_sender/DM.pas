unit DM;

interface

uses
  System.SysUtils, System.Classes, REST.Types, Data.DB, Data.Win.ADODB,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope;

type
  TfmDM = class(TDataModule)
    AS2033Connection: TADOConnection;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Query: TADOQuery;
    qRequests: TADOQuery;
    qMachines: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDM: TfmDM;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
