object fmDM: TfmDM
  OldCreateOrder = False
  Height = 452
  Width = 668
  object AS2033Connection: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 8
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    Params = <>
    Left = 88
    Top = 104
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 88
    Top = 152
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 88
    Top = 200
  end
  object Query: TADOQuery
    Connection = AS2033Connection
    Parameters = <>
    Left = 224
    Top = 16
  end
  object qRequests: TADOQuery
    Connection = AS2033Connection
    Parameters = <>
    SQL.Strings = (
      'select id as request_id from request')
    Left = 296
    Top = 128
  end
  object qMachines: TADOQuery
    Connection = AS2033Connection
    Parameters = <>
    SQL.Strings = (
      'select label, port from machines')
    Left = 296
    Top = 184
  end
end
