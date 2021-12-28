library sprightly.drift_database;

import 'dart:async';

import 'package:dart_marganam/db.dart';
import 'package:dart_marganam/extensions.dart';
import 'package:dart_marganam/utils.dart';
import 'package:drift/drift.dart';
import 'package:sprightly_inventory/core/config/enums.dart';

import '../dao.dart';
import '../db_config.dart';
import '../tables/app_tables.dart';
import '../tables/setup_tables.dart';

part 'database.g.dart';

String get _appDataDbFile => 'sprightly_inventory_db.lite';
String get _setupDataDbFile => 'sprightly_setup.lite';

const List<Type> _appTables = <Type>[
  Members,
  CustomProperties,
];
const List<Type> _appDaos = <Type>[
  SprightlyDao,
];
const List<Type> _setupTables = <Type>[
  // AppFonts,
  // FontCombos,
  // ColorCombos,
  AppSettings,
];
const List<Type> _setupDaos = <Type>[
  SprightlySetupDao,
];

@DriftAccessor(
  tables: _appTables,
)
class SprightlyDao extends DatabaseAccessor<SprightlyDatabase>
    with _$SprightlyDaoMixin, DaoMixin, ReadyOrNotMixin
    implements SystemDao {
  SprightlyDao(SprightlyDatabase _db) : super(_db) {
    getReadyWorker = _getReady;
    queries = QuerySet(
      queries: {
        CustomQueryType.defaultStartup.name:
            CustomQuery.fromAsset("defaultStartupStatement.sql"),
        CustomQueryType.dataInitiation.name:
            CustomQuery.fromAsset("dataInitiation.sql"),
        CustomQueryType.openingPragma.name:
            CustomQuery.fromAsset("openingPragma.sql"),
      },
      sqlSourceAssetDirectory: dbConfig.sqlSourceAsset,
    );
    hashMinLength = dbConfig.hashedIdMinLength;
    uniqueRetry = dbConfig.uniqueRetry;
  }

  @override
  bool get ready => super.daoMixinReady && super.ready;

  Future _getReady() async {
    updateDbEnumTypes();
    await super.getDaoMixinReady();
  }

  @override
  Future<void> beforeOpen(OpeningDetails details, Migrator m) async {
    await getReady();
    await super.beforeOpen(details, m);
    if (details.wasCreated) {
      // TODO: do first time activity
    }
  }

  @override
  Future<Member> getMember(String memberId) async =>
      Member.fromJson(await getRecord(members.actualTableName, memberId));

  @override
  Future<Member?> addMember(
    String idValue,
    String name, {
    String? id,
    String? avatar,
    MemberIdType idType = MemberIdType.NickName,
    String? signature,
  }) async {
    final _id = id ?? await uniqueId(members.actualTableName, [idValue]);
    final membersComp = MembersCompanion.insert(
      id: _id,
      name: name,
      avatar: Value(avatar),
      idType: Value(idType),
      idValue: Value(idValue),
      signature: Value(signature),
    );
    if (await into(members).insert(membersComp) > 0) {
      return getMember(_id);
    }
    return null;
  }

  @override
  Future<Member?> updateMember(
    String id, {
    String? name,
    String? avatar,
    MemberIdType? idType,
    String? idValue,
    String? signature,
  }) async {
    final existing = await getMember(id);
    final updated = existing.copyWith(
      name: name,
      avatar: avatar,
      idType: idType,
      idValue: idValue,
      signature: signature,
      updatedOn: DateTime.now().toUtc(),
    );
    if (await updateRecord(members, updated)) {
      return getMember(id);
    }
    return null;
  }

  @override
  Future<int> deleteMember(String id) =>
      deleteRecord(members, MembersCompanion(id: Value(id)));
}

@DriftAccessor(
  tables: _setupTables,
)
class SprightlySetupDao extends DatabaseAccessor<SprightlySetupDatabase>
    with _$SprightlySetupDaoMixin, DaoMixin, ReadyOrNotMixin
    implements SetupDao {
  SprightlySetupDao(SprightlySetupDatabase _db) : super(_db) {
    getReadyWorker = _getReady;
    queries = QuerySet(
      queries: {
        CustomQueryType.defaultStartup.name:
            CustomQuery.fromAsset("defaultStartupStatement.sql"),
        // ! TODO: _Web_ db doesn't support multi-statement, yet.
        CustomQueryType.dataInitiation.name:
            CustomQuery.fromAsset("setupInitiation.sql"),
        CustomQueryType.openingPragma.name:
            CustomQuery.fromAsset("openingPragma.sql"),
      },
      sqlSourceAssetDirectory: dbConfig.sqlSourceAsset,
    );
    hashMinLength = dbConfig.hashedIdMinLength;
    uniqueRetry = dbConfig.uniqueRetry;
  }

  @override
  bool get ready => super.daoMixinReady && _appInformation.ready && super.ready;

  Future _getReady() async {
    updateDbEnumTypes();
    await super.getDaoMixinReady();
    await _appInformation.getReady();
    _allAppSettings = await getAppSettings();
    // _allAppFonts = await getAppFonts();
    // _allFontCombos = await getFontCombos();
    // _allColorCombos = await getColorCombos();
  }

  @override
  Future<void> beforeOpen(OpeningDetails details, Migrator m) async {
    await getReady();
    await super.beforeOpen(details, m);
    if (details.wasCreated) {
      // TODO: do first time activity
      // already done through queries.setupInitiation
    }
    if (details.wasCreated || details.hadUpgrade) {
      // // * TODO: **TEMP** in case of _Web_ db
      // await addAppSetting('dbVersion', '0', PropertyType.Number);
      // await addAppSetting('primarySetupComplete', '0', PropertyType.Bool);
      // await addAppSetting('themeMode', 'Dark', PropertyType.String);
      // await addAppSetting('debug', '0', PropertyType.Bool);

      // sync dbVersion
      await updateAppSetting(
        'dbVersion',
        attachedDatabase.schemaVersion.toString(),
      );
      // print('allAppSetting: $_allAppSettings');
    }
  }

  final _appInformation = AppInformation();
  @override
  AppInformation get appInformation => _appInformation;
  late List<AppSetting> _allAppSettings;
  @override
  List<AppSetting> get allAppSettings => _allAppSettings;
  // List<AppFont> _allAppFonts;
  // List<AppFont> get allAppFonts => _allAppFonts;
  // List<FontCombo> _allFontCombos;
  // List<FontCombo> get allFontCombos => _allFontCombos;
  // List<ColorCombo> _allColorCombos;
  // List<ColorCombo> get allColorCombos => _allColorCombos;

  @override
  Future<List<AppSetting>> getAppSettings() => select(appSettings).get();

  @override
  Stream<List<AppSetting>> watchAppSettings() => select(appSettings).watch();

  @override
  Future<AppSetting> getAppSetting(String name) async => AppSetting.fromData(
        await getRecordWithColumnValue(
          appSettings.actualTableName,
          'name',
          name,
        ),
      );

  @override
  Future<AppSetting?> addAppSetting(
    String name,
    String value, {
    PropertyType type = PropertyType.String,
  }) async {
    final appSetting = AppSettingsCompanion.insert(
      name: name,
      value: value,
      type: Value(type),
    );
    if (await into(appSettings).insert(appSetting) > 0) {
      return getAppSetting(name);
    }
    return null;
  }

  @override
  Future<bool> updateAppSetting(
    String name,
    String value, {
    PropertyType? type,
    bool batchOperation = false,
  }) async {
    final existing = await getAppSetting(name);
    final updated = existing.copyWith(
      value: value,
      type: type,
      updatedOn: DateTime.now().toUtc(),
    );
    final result = updateRecord(appSettings, updated);
    if (!batchOperation) _allAppSettings = await getAppSettings();
    return result;
  }

  @override
  Future<bool> updateAppSettings(Map<String, String> settings) async {
    var result = true;
    settings.forEach(
      (name, value) async => result =
          result && await updateAppSetting(name, value, batchOperation: true),
    );
    _allAppSettings = await getAppSettings();
    return result;
  }

  // Future<List<AppFont>> getAppFonts() => select(appFonts).get();
  // Stream<List<AppFont>> watchAppFonts() => select(appFonts).watch();

  // Future<List<FontCombo>> getFontCombos() => select(fontCombos).get();
  // Stream<List<FontCombo>> watchFontCombos() => select(fontCombos).watch();

  // Future<List<ColorCombo>> getColorCombos() => select(colorCombos).get();
  // Stream<List<ColorCombo>> watchColorCombos() => select(colorCombos).watch();
}

@DriftDatabase(
  tables: _appTables,
  daos: _appDaos,
)
class SprightlyDatabase extends _$SprightlyDatabase
    implements Initiated, Disposable<bool> {
  String? dbFile;
  bool? enableDebug;
  bool? recreateDatabase;
  SprightlyDatabase({
    this.dbFile,
    this.enableDebug,
    this.recreateDatabase,
  }) : super(
          openConnection(
            dbFile ?? _appDataDbFile,
            logStatements: enableDebug,
            recreateDatabase: recreateDatabase,
          ),
        );

  @override
  FutureOr initiate() async {
    await executor.ensureOpen(attachedDatabase);
    await sprightlyDao.getReady();
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: sprightlyDao.onCreate,
        onUpgrade: sprightlyDao.onUpgrade,
        beforeOpen: (OpeningDetails details) async {
          final m = createMigrator();
          await sprightlyDao.beforeOpen(details, m);
        },
      );

  @override
  FutureOr dispose([bool? flag]) async {
    await close();
  }
}

@DriftDatabase(
  tables: _setupTables,
  daos: _setupDaos,
)
class SprightlySetupDatabase extends _$SprightlySetupDatabase
    implements Initiated, Disposable<bool> {
  String? dbFile;
  bool? enableDebug;
  bool? recreateDatabase;
  SprightlySetupDatabase({
    this.dbFile,
    this.enableDebug,
    this.recreateDatabase,
  }) : super(
          openConnection(
            dbFile ?? _setupDataDbFile,
            logStatements: enableDebug,
            recreateDatabase: recreateDatabase,
          ),
        );

  @override
  FutureOr initiate() async {
    await executor.ensureOpen(attachedDatabase);
    await sprightlySetupDao.getReady();
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: sprightlySetupDao.onCreate,
        onUpgrade: sprightlySetupDao.onUpgrade,
        beforeOpen: (OpeningDetails details) async {
          final m = createMigrator();
          await sprightlySetupDao.beforeOpen(details, m);
        },
      );

  @override
  FutureOr dispose([bool? flag]) async {
    await close();
  }
}
