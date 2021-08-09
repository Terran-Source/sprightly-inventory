import 'enums.dart';

class AppSettingNames {
  const AppSettingNames._();
  static AppSettingNames universal = AppSettingNames._();
  factory AppSettingNames() => universal;

  // App Information
  String get appName => 'appName';
  String get packageName => 'packageName';
  String get version => 'version';
  String get buildNumber => 'buildNumber';

  // Debug related
  Environment get environment => Environment.Development;
  bool get debug => false;

  // database related
  double get dbVersion => 1.0;

  // database AppSettings
  String get primarySetupComplete => 'primarySetupComplete';

  // Themes
  ThemeMode get themeMode => ThemeMode.Bright;
}
