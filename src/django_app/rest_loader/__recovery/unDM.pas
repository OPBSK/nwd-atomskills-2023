unit unDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope;

type
  TfmDM = class(TDataModule)
    AS2033Connection: TADOConnection;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Query: TADOQuery;
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
