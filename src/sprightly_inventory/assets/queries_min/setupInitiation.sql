BEGIN TRANSACTION;
INSERT INTO AppSetting(name,value,type) VALUES('dbVersion','0','Number');
INSERT INTO AppSetting(name,value,type) VALUES('primarySetupComplete','0','Bool');
INSERT INTO AppSetting(name,value,type) VALUES('themeMode','Dark','String');
INSERT INTO AppSetting(name,value,type) VALUES('debug','0','Bool');
COMMIT;
