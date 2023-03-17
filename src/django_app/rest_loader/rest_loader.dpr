program rest_loader;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils, ActiveX, ComObj, Variants, json,
  unDM in 'unDM.pas' {fmDM: TDataModule};

var
  i: Integer;
  rest_server, rest_key: String;
  sql_hostname, sql_login, sql_password: String;

function get_json_send_to_db(_resource_path: String; _proc_path: String): Integer;
// var   json: String;
begin
  // ����� �� ��������� �������
  // ����� �� ��������� ����� ��������� �� SQL

  // ��������
  try
    with fmDM do
    begin
      RESTRequest1.Resource := _resource_path;
      RESTRequest1.Execute;

      // json := RESTResponse1.JSONText;

      // ����������
      Query.sql.Text := 'exec ' + _proc_path + ',@json=' + QuotedStr(RESTResponse1.JSONText);
      Query.Open;
      result := Query.FieldByName('result').Value;
    end;
  except
    on E: Exception do
      writeln('REST TO DB: ', E.ClassName, ': ', E.Message);

  end;
end;

{
  procedure GetRestTest(_resource: String; data_path: String; values_count: Integer);
  var
  JSONValue: TJSONValue;
  j, k: Integer;
  S, json: String;
  Values: Array of string;

  jo: TJSONObject;
  myarr: TJSONArray;
  begin
  // �������� ������ �����������
  with fmDM do
  begin
  RESTRequest1.Resource := _resource;
  RESTRequest1.Execute;

  json := RESTResponse1.JSONText;
  jo := TJSONObject.ParseJSONValue(json) as TJSONObject;
  try
  if jo.TryGetValue('data', myarr) and (myarr.Count > 0) then
  begin
  for j := 0 to myarr.Count - 1 do
  begin
  SetLength(Values, 0);
  SetLength(Values, values_count);
  myarr.Items[j].TryGetValue('id', Values[0]);
  myarr.Items[j].TryGetValue('email', Values[1]);
  myarr.Items[j].TryGetValue('first_name', Values[2]);
  myarr.Items[j].TryGetValue('last_name', Values[3]);

  // ����� ������ � ���������� ��������
  S := '';
  for k := 0 to values_count - 1 do
  begin
  S := S + Values[k] + ',';
  end;
  writeln(S);
  end;

  end;
  finally
  jo.Free;
  end;

  JSONValue := RESTResponse1.JSONValue;
  for j := 0 to TJSONArray(JSONValue).Count - 1 do
  begin
  SetLength(Values, 0);
  SetLength(Values, values_count);
  JSONValue.TryGetValue<string>('data.[' + j.ToString + '].id', Values[0]);
  JSONValue.TryGetValue<string>('data.[' + j.ToString + '].email', Values[1]);
  JSONValue.TryGetValue<string>('data.[' + j.ToString + '].first_name', Values[2]);
  JSONValue.TryGetValue<string>('data.[' + j.ToString + '].last_name', Values[3]);
  JSONValue.TryGetValue<string>('data.[' + j.ToString + '].avatar', Values[4]);

  for k := 0 to values_count - 1 do
  begin
  S := S + ',' + Values[k];
  end;
  writeln(S);
  end;

  end;
  end;
}

begin
  CoInitialize(nil);
  try
    try
      try
        fmDM := TfmDM.Create(nil);
        // �������� ���������
        If ParamCount > 0 Then
        begin
          for i := 1 to ParamCount do
          begin
            If ParamStr(i) = '-login' Then
            begin
              //
              if i < ParamCount then
                sql_login := ParamStr(i + 1);
            end
            else If ParamStr(i) = '-password' Then
            begin
              //
              if i < ParamCount then
                sql_password := ParamStr(i + 1);
            end
            else If ParamStr(i) = '-rest' Then
            begin
              //
              if i < ParamCount then
                rest_server := ParamStr(i + 1);
            end
            else If ParamStr(i) = '-key' Then
            begin
              //
              if i < ParamCount then
                rest_key := ParamStr(i + 1);
            end
            else If ParamStr(i) = '-host' Then
            begin
              //
              if i < ParamCount then
                sql_hostname := ParamStr(i + 1);
            end;
          end;

        end;
        writeln('host=' + sql_hostname + ', login=' + sql_login + ', password=' + sql_password + ', server=' +
          rest_server + ', key=' + rest_key);

        if (rest_server = '') or (rest_key = '') or (sql_login = '') or (sql_password = '') then
        begin
          //
          writeln('I need parameters -host -login -password -rest -key');
        end;

        // TEST
        rest_server := 'https://reqres.in';
        rest_key := 'qwerty';
        sql_hostname := 'HOME-PC\SQLEXPRESS';
        sql_login := 'django_user';
        sql_password := 'django_user';
        // TEST

        // ���������  ����������� � sql
        try
          fmDM.AS2033Connection.ConnectionString :=
            'Provider=SQLOLEDB.1;Persist Security Info=False;Initial Catalog=AS2033;Data Source=' +
            sql_hostname + ';';
          fmDM.AS2033Connection.Open(sql_login, sql_password);
          writeln('sql connection ...OK');
        except
          on E: Exception do
            writeln('SQL: ', E.ClassName, ': ', E.Message);
        end;

        // ��������� ����������� � ����
        fmDM.RESTClient1.BaseURL := rest_server;
        begin
          try
            i := get_json_send_to_db('api/users?page=2', '_test_rest_ins_json @page=2');
            if i > 0 then
              writeln('REST connection ...OK')
            else
              writeln('REST connection ...FAILED');
          except
            on E: Exception do
              writeln('REST: ', E.ClassName, ': ', E.Message);

          end;
        end;

        // ��������� ���� ���������� � ���������� ������

      finally
        fmDM.Free;
      end
    except
      on E: Exception do
        writeln(E.ClassName, ': ', E.Message);

    end;
  finally
    CoUninitialize;
  end;

end.