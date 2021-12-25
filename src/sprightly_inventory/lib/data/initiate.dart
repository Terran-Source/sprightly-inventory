import 'package:dart_marganam/utils.dart';
import 'package:kiwi/kiwi.dart';
import 'package:sprightly_inventory/core/config/app_config.dart';
import 'package:sprightly_inventory/core/config/enums.dart';
import 'package:sprightly_inventory/data/dao.dart';
import 'package:sprightly_inventory/data/datasources/database.dart' as db;

Future<Iterable<Initiated>> initiate(
  KiwiContainer kiwiContainer,
  AppConfig configurations, {
  Environment environment = Environment.prod,
}) async {
  final result = <Initiated>[];

  db.dbConfig.update(
    sqlSourceAsset: configurations.dbConfig?.sqlSourceAsset,
    sqlSourceWeb: configurations.dbConfig?.sqlSourceWeb,
    hashedIdMinLength: configurations.dbConfig?.hashedIdMinLength,
    uniqueRetry: configurations.dbConfig?.uniqueRetry,
  );

  final dataDb = db.SprightlyDatabase(
    dbFile: configurations.dbConfig?.appDataDbFile,
    enableDebug: configurations.debug,
    recreateDatabase: configurations.recreateDatabase,
  );
  kiwiContainer
    ..registerSingleton((container) => dataDb)
    ..registerSingleton<SystemDao>((container) => dataDb.sprightlyDao);
  result.add(dataDb);

  final settingsDb = db.SprightlySetupDatabase(
    dbFile: configurations.dbConfig?.setupDataDbFile,
    enableDebug: configurations.debug,
    recreateDatabase: configurations.recreateDatabase,
  );
  kiwiContainer
    ..registerSingleton((container) => settingsDb)
    ..registerSingleton<SetupDao>((container) => settingsDb.sprightlySetupDao);
  result.add(settingsDb);

  // initialize global dao
  final appInfo = AppInformation();
  kiwiContainer.registerSingleton((container) => appInfo);
  result.add(appInfo);

  return result;
}
