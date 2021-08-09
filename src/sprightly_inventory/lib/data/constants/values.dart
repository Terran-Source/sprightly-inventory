import 'enums.dart';

class AppSettingNames {
  factory AppSettingNames() => universal;
  static AppSettingNames universal = const AppSettingNames._();
  const AppSettingNames._();

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
