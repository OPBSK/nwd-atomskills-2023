@echo off

rem Задайте путь к исполняемому файлу и интервал исполнения
for %%i in ("%~dp0\rest_sender.exe") do set exePathLoader=%%~fi
set intervalLoader=3

for %%i in ("%~dp0\mail_server.exe") do set exePathMailServer=%%~fi
set intervalMailServer=3

set taskNameLoader=LoadRESTAPI
set taskNameMailServer=MailServer

schtasks /create /tn "%taskNameLoader%" /sc minute /mo "%intervalLoader%" /tr "%exePathLoader% -mode load"

schtasks /create /tn "%taskNameMailServer%" /sc minute /mo "%intervalMailServer%" /tr "%exePathMailServer%"

