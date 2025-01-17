object dm: Tdm
  OldCreateOrder = False
  Height = 819
  Width = 1162
  object idIMAPGet: TIdIMAP4
    IOHandler = IdSSLGet
    Port = 993
    Host = 'imap.gmail.com'
    UseTLS = utUseImplicitTLS
    SASLMechanisms = <>
    MilliSecsToWaitToClearBuffer = 10
    Left = 48
    Top = 177
  end
  object IdSSLGet: TIdSSLIOHandlerSocketOpenSSL
    Destination = 'imap.gmail.com:993'
    Host = 'imap.gmail.com'
    MaxLineAction = maException
    Port = 993
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 114
    Top = 177
  end
  object IdMessageGet: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 178
    Top = 177
  end
  object IdSSLSend: TIdSSLIOHandlerSocketOpenSSL
    Destination = 'smtp.gmail.com:587'
    Host = 'smtp.gmail.com'
    MaxLineAction = maException
    Port = 587
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 114
    Top = 81
  end
  object IdMessageSend: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CharSet = 'koi8-r'
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 178
    Top = 80
  end
  object IdSMTPSend: TIdSMTP
    IOHandler = IdSSLSend
    Host = 'smtp.gmail.com'
    Port = 587
    SASLMechanisms = <>
    UseTLS = utUseExplicitTLS
    Left = 48
    Top = 80
  end
  object conAS: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 80
    Top = 272
  end
  object sp_check_role: TADOStoredProc
    Connection = conAS
    ProcedureName = 'dbo.check_role;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@role_name'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end>
    Left = 80
    Top = 336
  end
  object tmrGetEmails: TTimer
    Enabled = False
    Interval = 300000
    OnTimer = tmrGetEmailsTimer
    Left = 368
    Top = 256
  end
  object tmrGetToSend: TTimer
    Enabled = False
    Interval = 300000
    OnTimer = tmrGetToSendTimer
    Left = 368
    Top = 320
  end
  object sp_email_send_get: TADOStoredProc
    Connection = conAS
    ProcedureName = 'email_to_send_get;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end>
    Left = 376
    Top = 48
  end
  object sp_email_sended: TADOStoredProc
    Connection = conAS
    ProcedureName = 'email_sended;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@id_claim_message'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 480
    Top = 48
  end
  object sp_create_claim: TADOStoredProc
    Connection = conAS
    ProcedureName = 'ADM.email_create_claim;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@user_mail'
        Attributes = [paNullable]
        DataType = ftString
        Size = 255
        Value = Null
      end
      item
        Name = '@text_message'
        Attributes = [paNullable]
        DataType = ftString
        Size = 2147483647
        Value = Null
      end
      item
        Name = '@header_message'
        Attributes = [paNullable]
        DataType = ftString
        Size = 255
        Value = Null
      end
      item
        Name = '@status'
        Attributes = [paNullable]
        DataType = ftLargeint
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end>
    Left = 608
    Top = 48
  end
  object sp_email_send_status: TADOStoredProc
    Connection = conAS
    ProcedureName = 'ADM.email_send_status;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@login'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end>
    Left = 480
    Top = 104
  end
end
