-- setupInitiation --
-- Indexes
-- Triggers
-- Insert
BEGIN TRANSACTION;
-- table: AppFonts
-- table: FontCombos
-- table: ColorCombos
-- table: AppSettings
INSERT INTO AppSettings(name,value,type) VALUES('dbVersion', '1', 'Number');
INSERT INTO AppSettings(name,value,type) VALUES('primarySetupComplete', 'false', 'Bool');
INSERT INTO AppSettings(name,value,type) VALUES('themeMode', 'Dark', 'ThemeMode');
INSERT INTO AppSettings(name,value,type) VALUES('debug','false','Bool');

END TRANSACTION;
