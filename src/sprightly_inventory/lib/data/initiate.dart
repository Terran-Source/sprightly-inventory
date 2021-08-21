import 'package:dart_marganam/utils.dart';
import 'package:kiwi/kiwi.dart';
import 'package:sprightly_inventory/core/config/app_config.dart';
import 'package:sprightly_inventory/data/constants/enums.dart';
import 'package:sprightly_inventory/data/dao.dart';
import 'package:sprightly_inventory/data/datasources/database.dart' as db;

Future<Iterable<Initiated>> initiate(
  KiwiContainer kiwiContainer, {
  Environment? environment,
  AppConfig configurations = const AppConfig(),
}) async {
  final result = <Initiated>[];

  final dataDb = db.SprightlyDatabase(
      enableDebug: configurations.debug,
      recreateDatabase: configurations.recreateDatabase);
  kiwiContainer.registerSingleton((container) => dataDb);
  kiwiContainer
      .registerSingleton<SystemDao>((container) => dataDb.sprightlyDao);
  result.add(dataDb);

  final settingsDb = db.SprightlySetupDatabase(
      enableDebug: configurations.debug,
      recreateDatabase: configurations.recreateDatabase);
  kiwiContainer.registerSingleton((container) => settingsDb);
  kiwiContainer.registerSingleton<SettingsDao>(
      (container) => settingsDb.sprightlySetupDao);
  result.add(settingsDb);

  // initialize global dao
  final appInfo = AppInformation();
  kiwiContainer.registerSingleton((container) => appInfo);
  result.add(appInfo);

  return result;
}
