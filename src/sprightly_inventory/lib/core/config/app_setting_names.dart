import 'constants.dart' as constants;
import 'enums.dart';

class AppSettingNames {
  factory AppSettingNames() => universal;
  static AppSettingNames universal = const AppSettingNames._();
  const AppSettingNames._();

  // App Information
  String get appName => constants.appNameSetting;
  String get packageName => constants.packageNameSetting;
  String get version => constants.versionSetting;
  String get buildNumber => constants.buildNumberSetting;

  // Debug related
  Environment get environment => Environment.dev;
  bool get debug => false;

  // database related
  double get dbVersion => 1.0;

  // database AppSettings
  String get primarySetupComplete => constants.setupCompleteSetting;

  // Themes
  ThemeMode get themeMode => ThemeMode.Dark;
}
