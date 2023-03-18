## Приложение AUMANU - планирование производства

Чтобы развернуть наше приложение необходимо выполнить некоторые действия:
### Подготовка сервера базы данных

 1. Скачайте и установите https://www.microsoft.com/ru-RU/download/details.aspx?id=101064 Microsoft SQL Server 2019 (RTM) - 15.0.2000.5 (X64)
 2.  Настройте SQL сервер зайдя в пуск -> в поиске введите SQL server 2019 Configuration Manager, зайдите в него в категории "Службы SQL Server" необходимо проверить, что включен сам SQL Server(SQLEXPRESS) и включен Обозреватель SQL Server.
![enter image description here](https://i.imgur.com/hNwlfje.png)
 3. В категории "Настройка клиента Native Client SQL вашей версии и разрядности",  в категории TCP/IP 	включить протокол	в свойствах этого протокола установить порт по умолчанию 1433.
![enter image description here](https://i.imgur.com/OAVL139.png)
4. В категории Сетевая конфигурация SQL Server, открыть категорию Протоколы для SQLEXPRESS двойным кликом мыши, так же необходимо включить протокол TPC/IP, в свойствах протокола во вкладке протокол убедиться, что он включен и прослушивать все стоит "Да". Во вкладке IP-адреса в категории IPAII установить порт 1433 и активировать категории IP с вами ip-адресом сервера.
<<<<<<< Updated upstream
5. После чего необходимо авторизоваться на сервере базы данных с помощью учетной записи системного администратора(sa) и создать базу данных AS2033, нажав правой кнопкой на папке Базы данных -> Создать базу данных.
6. Перейти в созданную базу данных. Выполнить скрипт deploy.sql данный скрипт создает структуру базы БД, в базе данных AS2033 и пользователя с логином django_user и паролем django_user.
=======
5. Так же должен быть открыть порт 1433 и IP-адрес в Windows Брендмауэр
6. После чего необходимо авторизоваться на сервере базы данных с помощью учетной записи системного администратора(sa) и создать базу данных AS2033, нажав правой кнопкой на папке Базы данных -> Создать базу данных.
7. Перейти в созданную базу данных. Выполнить скрипт deploy.sql данный скрипт создает структуру базы БД, в базе данных AS2033 и пользователя с логином django_user и паролем django_user.
>>>>>>> Stashed changes

### Подготовка web-приложения
 1. Скачайте и установите Python 3.11.2 с официального сайта: https://www.python.org/downloads/ при установки поставьте галочку Add Python to PATH
 2. При необходимости (если python не хочет выполнять команды) открываем терминал PowerShell от админа, Вставляем и запускаем - "Set-ExecutionPolicy RemoteSigned", На вопрос отвечаем - A
 3. Необходимо отредактировать файл settings.py находящийся в папке src/django_app/main/settings.py пролистайте до DATABASES и отредактируйте в конфигурации поля
    HOST - адрес сервера базы данных(IP-адресс вашего сервера c экземпляром например: '0.0.0.0\SQLEXPRESS');
    PORT - порт сервера базы данных (изменить если иной);
    NAME - имя базы данных(должен быть AS2033);
    USER - логин администратора(должен быть django_user);
    PASSWORD - пароль администратора(должен быть django_user).
   
 4. Запускаем скрипт файл src/django_app/setup.bat, который установить зависимости проекта.
 5. Зайти в папку src/django_app/tools/ и отредактировать ini файл config.ini data_source - адрес сервера базы данных(IP-адресс вашего сервера c экземпляром например: '0.0.0.0\SQLEXPRESS'). В параметре REST API url - указать базовый путь и порт до crm api.
 6. Запустить скрипт от имени администратора src/django_app/tools/run_schtasks.bat он создаст задание на синхронизацию с crm системой и запустит сервис почты.
 7. Запускам приложение с помощью файла run_django.bat, сервер запуститься на ip-адресе текущего компьютера с портом 8000.
 8. После запуска приложение доступно с IP-адреса (напр. x.x.x.x:8000) откуда было запущено приложение, 
либо с IP-адреса 127.0.0.0:8000 если находитесь на этом же компьютере,
указание порта в адрсеной строке обязательно, если порт занят, то поменяйте его на другой (напр. 9000, 7000, 6000).
 9.  Необходимо зайти по адресу приложения на ресурс /admin/, авторизоваться с помощью логина admin пароля admin. Зайти во вкладку Users и отредактируйте пользователя user поле email вписав ваш email, на который будут приходить уведомления из системы.
 10. Приложение развернуто.

