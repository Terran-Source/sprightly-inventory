import 'package:dart_marganam/utils/initiated.dart';
import 'package:kiwi/kiwi.dart';
import 'package:sprightly_inventory/core/config/app_config.dart';
import 'package:sprightly_inventory/core/config/enums.dart';
import 'package:sprightly_inventory/data/data.dart';

Future<Iterable<Initiated>> initiate(
  KiwiContainer kiwiContainer,
  AppConfig configurations, {
  Environment environment = Environment.prod,
}) async {
  final result = <Initiated>[];

  dbConfig.update(
    sqlSourceAsset: configurations.dbConfig?.sqlSourceAsset,
    sqlSourceWeb: configurations.dbConfig?.sqlSourceWeb,
    hashedIdMinLength: configurations.dbConfig?.hashedIdMinLength,
    uniqueRetry: configurations.dbConfig?.uniqueRetry,
  );

  final dataDb = SprightlyDatabase(
    dbFile: configurations.dbConfig?.appDataDbFile,
    enableDebug: configurations.debug,
    recreateDatabase: configurations.recreateDatabase,
  );
  kiwiContainer
    ..registerSingleton((container) => dataDb)
    ..registerSingleton<SystemDao>((container) => dataDb.sprightlyDao);
  result.add(dataDb);

  final setupDb = SprightlySetupDatabase(
    dbFile: configurations.dbConfig?.setupDataDbFile,
    enableDebug: configurations.debug,
    recreateDatabase: configurations.recreateDatabase,
  );
  kiwiContainer
    ..registerSingleton((container) => setupDb)
    ..registerSingleton<SetupDao>((container) => setupDb.sprightlySetupDao);
  result.add(setupDb);

  // initialize global dao
  final appInfo = AppInformation();
  kiwiContainer.registerSingleton((container) => appInfo);
  result.add(appInfo);

  return result;
}
