CREATE LOGIN [django_user] WITH PASSWORD = 'django_user' ,
DEFAULT_DATABASE = AS2033,
CHECK_POLICY =  OFF,
CHECK_EXPIRATION =  OFF;
USE AS2033;
CREATE USER [django_user] FOR LOGIN [django_user];
EXEC sp_addrolemember N'db_owner', N'django_user';
