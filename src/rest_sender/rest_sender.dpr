program rest_sender;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils, ActiveX, ComObj, Variants, json, strutils, rest.types, inifiles,
  DM in 'DM.pas' {fmDM: TDataModule};

var
  i: Integer;
  f: Double;
  rest_server, rest_port, app_mode, app_param1, app_param2, app_param3: String;
  sql_hostname, sql_db, sql_login, sql_password: String;
  _machine_port, _request_id: String;
  config: TIniFile;

function send_post_with_body(_resource_path, _port, _product_id: String): Integer;
var
  json: String;
  jso, jso2: TJSONObject;
  j: TJsonValue;
begin
  // делает POST
  // может не оказатьс€ ресурса
  // может не оказатьс€ такой процедуры на SQL

  // получаем
  try
    with fmDM do
    begin
      json := '{"advInfo":{"productId":"' + _product_id + '"}}';

      jso := TJSONObject.ParseJSONValue(json, False, True) as TJSONObject;

      RESTClient1.BaseURL := rest_server + ':' + _port;
      RESTRequest1.Method := rmPOST;
      RESTRequest1.Resource := _resource_path;
      RESTRequest1.AddBody(jso);
      RESTRequest1.Execute;

    end;
  except
    on E: Exception do
      writeln('send_post_with_body: ', E.ClassName, ': ', E.Message);

  end;
end;

function send_post(_resource_path: String): Integer;
begin
  // делает POST
  // может не оказатьс€ ресурса
  // может не оказатьс€ такой процедуры на SQL

  // получаем
  try
    with fmDM do
    begin
      // обычный пор

      RESTClient1.BaseURL := rest_server + ':' + rest_port;
      RESTRequest1.Method := rmPOST;
      RESTRequest1.Resource := _resource_path;
      RESTRequest1.ClearBody;
      RESTRequest1.Execute;

    end;
  except
    on E: Exception do
      writeln('send_post: ', E.ClassName, ': ', E.Message);

  end;
end;

function get_machine_status_send_to_db(_port: String; _proc_path: String): Integer;
begin
  // может не оказатьс€ ресурса
  // может не оказатьс€ такой процедуры на SQL
  //
  // получаем
  try
    with fmDM do
    begin
      // http://localhost:1041/status
      // порт этого станка
      RESTClient1.BaseURL := rest_server + ':' + _port;
      RESTRequest1.Resource := 'status';
      RESTRequest1.Method := rmGET;
      RESTRequest1.ClearBody;
      RESTRequest1.Execute;

      // json := RESTResponse1.JSONText;

      if (_proc_path <> '') then
      begin
        // отправл€ем
        Query.Close;
        Query.sql.Text := 'exec ' + _proc_path + ' @json=' + QuotedStr(RESTResponse1.JSONText);
        Query.Open;
        result := Query.FieldByName('result').Value;
      end
      else
      //если станок был сломан, то возвращает 1
      begin
        if pos('BROKEN', RESTResponse1.JSONText) >-1 then
          result := 1
        else
          result := 0;
      end;

    end;
  except
    on E: Exception do
      writeln('get_machine_status_send_to_db: ', E.ClassName, ': ', E.Message);

  end;
end;

function get_json_send_to_db(_resource_path: String; _proc_path: String): Integer;
begin
  // может не оказатьс€ ресурса
  // может не оказатьс€ такой процедуры на SQL

  // получаем
  try
    with fmDM do
    begin
      // обычный порт
      RESTClient1.BaseURL := rest_server + ':' + rest_port;
      RESTRequest1.Method := rmGET;
      RESTRequest1.Resource := _resource_path;
      RESTRequest1.ClearBody;
      RESTRequest1.Execute;

      // json := RESTResponse1.JSONText;

      // отправл€ем
      if _proc_path <> '' then
      begin
        Query.Close;
        Query.sql.Text := 'exec ' + _proc_path + ' @json=' + QuotedStr(RESTResponse1.JSONText);
        Query.Open;
        result := Query.FieldByName('result').Value;
      end
      else
        result := 1;
    end;
  except
    on E: Exception do
      writeln('get_json_send_to_db: ', E.ClassName, ': ', E.Message);

  end;
end;

begin
  CoInitialize(nil);
  try
    try
      try
        fmDM := TfmDM.Create(nil);

        // получаем настройки из файла
        config := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
        try
          // бд
          // sql_hostname := config.ReadString('DATA_BASE','provider','');
          // persist_security_info := config.ReadString('DATA_BASE','persist_security_info','');
          sql_login := config.ReadString('DATA_BASE', 'user_id', '');
          sql_password := config.ReadString('DATA_BASE', 'password', '');
          sql_db := config.ReadString('DATA_BASE', 'initial_catalog', '');
          sql_hostname := config.ReadString('DATA_BASE', 'data_source', '');
          rest_server := config.ReadString('REST_API', 'url', '');
          // выделим порт
          rest_port := MidStr(rest_server, posEx(':', rest_server, 7) + 1, 100);
          // выделим сервер
          rest_server := MidStr(rest_server, 1, posEx(':', rest_server, 7) - 1);
        finally
          config.Free;
        end;

        // получаем параметры
        If ParamCount > 0 Then
        begin
          for i := 1 to ParamCount do
          begin
            { If ParamStr(i) = '-login' Then
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
              begin
              // обща€ строка
              rest_server := ParamStr(i + 1);
              // выделим порт
              rest_port := MidStr(rest_server, posEx(':', rest_server, 7) + 1, 100);
              // выделим сервер
              rest_server := MidStr(rest_server, 1, posEx(':', rest_server, 7) - 1);
              end;

              end
              else  If ParamStr(i) = '-host' Then
              begin
              //
              if i < ParamCount then
              sql_hostname := ParamStr(i + 1);
              end
              else If ParamStr(i) = '-db' Then
              begin
              //
              if i < ParamCount then
              sql_db := ParamStr(i + 1);
              end else }
            If ParamStr(i) = '-mode' Then
            begin
              //
              if i < ParamCount then
                app_mode := ParamStr(i + 1);
            end

            else If ParamStr(i) = '-param1' Then
            begin
              //
              if i < ParamCount then
                app_param1 := ParamStr(i + 1);
            end

            else If ParamStr(i) = '-param2' Then
            begin
              //
              if i < ParamCount then
                app_param2 := ParamStr(i + 1);
            end

            else If ParamStr(i) = '-param3' Then
            begin
              //
              if i < ParamCount then
                app_param3 := ParamStr(i + 1);
            end;
          end;
        end;
        {
          writeln('host=' + sql_hostname + ', db=' + sql_db + ', login=' + sql_login + ', password=' +
          sql_password + ', rest=' + rest_server + ', port=' + rest_port + ', mode=' + app_mode);
        }
        if (sql_db = '') or (rest_server = '') or (rest_port = '') or (app_mode = '') or (sql_login = '') or
          (sql_password = '') or (sql_hostname = '') then
        begin
          //
          writeln('no enough parameters');
        end;

        // провер€ем  подключение к sql
        try
          fmDM.AS2033Connection.ConnectionString :=
            'Provider=SQLOLEDB.1;Persist Security Info=False;Initial Catalog=' + sql_db + ';Data Source=' +
            sql_hostname + ';';
          fmDM.AS2033Connection.Open(sql_login, sql_password);
          // writeln('sql connection ...OK');
        except
          on E: Exception do
            writeln('SQL: ', E.ClassName, ': ', E.Message);
        end;

        // провер€ем подключение к рест
        fmDM.RESTClient1.BaseURL := rest_server;

        // send_post_body('set/working', '1045', '40');
        {
          begin
          try
          i := get_json_send_to_db('dict/contractors', '');
          if i > 0 then
          writeln('REST connection ...OK')
          else
          writeln('REST connection ...FAILED');
          except
          on E: Exception do
          writeln('REST: ', E.ClassName, ': ', E.Message);

          end;
          end;
        }
        if app_mode = 'load' then
        begin
          // выполн€ем цикл скачиваний и обновлений данных
          // словари
          get_json_send_to_db('dict/contractors', '_json_contractors');
          get_json_send_to_db('dict/products', '_json_products');

          get_json_send_to_db('/crm/requests', '_json_requests');
          get_json_send_to_db('mnf/machines', '_json_machines');

          // состав заказа
          // нужен список заказов
          // можно тупо из нашей Ѕƒ
          with fmDM.qRequests do
          begin
            Close;
            Open;
            while not Eof do
            begin
              get_json_send_to_db('crm/requests/' + FieldByName('request_id').asstring + '/items',
                '_json_request_items @request_id=' + FieldByName('request_id').asstring + ',');
              Next;
            end;
            Close;
          end;
          // статусы станков
          // требуетс€ список станков (порт)
          // можно тупо из нашей Ѕƒ
          with fmDM.qMachines do
          begin
            Close;
            Open;
            while not Eof do
            begin
              get_machine_status_send_to_db(FieldByName('port').asstring, '_json_machine_status @port=' +
                FieldByName('port').asstring + ',');
              Next;
            end;
            Close;
          end;

          // провер€ем на новые поломанные
          fmDM.Query.Close;
          fmDM.Query.sql.Text := 'exec _check_for_broken';
          fmDM.Query.Open;

          // возвращает список, кого переназначили  на работы
          while not fmDM.Query.Eof do
          begin
            send_post_with_body('set/working', fmDM.Query.FieldByName('port').asstring,
              fmDM.Query.FieldByName('product_id').asstring);
            fmDM.Query.Next;
          end;

        end;
        if app_mode = 'repair' then
        begin
          if get_machine_status_send_to_db(app_param1, '') = 1 then
            send_post_with_body('set/repairing', app_param1, '');
        end;

        if app_mode = 'approve' then
        begin
          // вызывает процедуру, еще раз провер€ет что все ок
          fmDM.Query.Close;
          fmDM.Query.sql.Text := 'exec _check_for_approve ' + app_param1;
          fmDM.Query.Open;

          if (fmDM.Query.FieldByName('result').asstring = '1') then
          begin
            // все хорошо
            // проставл€ем у заказа статус
            send_post('/crm/requests/' + app_param1 + '/set-state/in-production');

            fmDM.Query.Close;
            fmDM.Query.sql.Text := 'exec _set_request_approve ' + app_param1;
            fmDM.Query.Open;

            // у всех станков ставит на какой продукт
            while not fmDM.Query.Eof do
            begin
              send_post_with_body('set/working', fmDM.Query.FieldByName('port').asstring,
                fmDM.Query.FieldByName('product_id').asstring);
              fmDM.Query.Next;
            end;
          end;

        end;
      finally
        fmDM.Free;
      end;
    except
      on E: Exception do
        writeln(E.ClassName, ': ', E.Message);
    end;
  finally
    CoUninitialize;
  end;

end.
