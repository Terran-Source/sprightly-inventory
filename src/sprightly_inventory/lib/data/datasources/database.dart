library sprightly.drift_database;

import 'dart:async';

import 'package:dart_marganam/db.dart';
import 'package:dart_marganam/extensions.dart';
import 'package:dart_marganam/utils.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sprightly_inventory/core/config/enums.dart';

import '../dao.dart';
import '../db_config.dart';

export '../db_config.dart';

part 'database.g.dart';

String get _appDataDbFile => 'sprightly_inventory_db.lite';
String get _setupDataDbFile => 'sprightly_setup.lite';

const List<Type> _appTables = <Type>[
  Members,
  CustomProperties,
  // Groups,
  // GroupMembers,
  // Accounts,
  // Categories,
  // Settlements,
  // Transactions,
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

// #region Sprightly tables
@DataClassName("Member")
class Members extends Table {
  @override
  String get tableName => "Member";

  TextColumn get id => text().named('id').withLength(min: 16)();
  TextColumn get name => text().named('name').withLength(max: 500)();
  TextColumn get avatar => text().named('avatar').nullable()();
  TextColumn get idType => text()
      .named('idType')
      .nullable()
      .map(const EnumTextConverter<MemberIdType>(MemberIdType.values))();
  TextColumn get idValue =>
      text().named('idValue').nullable().withLength(max: 50)();
  TextColumn get signature => text().named('signature').nullable()();
  DateTimeColumn get createdOn => dateTime()
      .named('createdOn')
      .clientDefault(() => DateTime.now().toUtc())
      .customConstraint("NOT NULL DEFAULT (STRFTIME('%s','now'))")();
  DateTimeColumn get updatedOn => dateTime()
      .named('updatedOn')
      .nullable()
      .clientDefault(() => DateTime.now().toUtc())();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName("CustomProperty")
class CustomProperties extends Table {
  @override
  String get tableName => "CustomProperty";

  TextColumn get id => text().named('id').withLength(min: 16)();
  TextColumn get parent => text().named('parent').withLength(min: 50)();
  TextColumn get parentId => text().named('parentId').withLength(min: 16)();
  TextColumn get propertyType => text()
      .named('propertyType')
      .map(const EnumTextConverter<PropertyType>(PropertyType.values))();
  TextColumn get name => text().named('name').withLength(max: 250)();
  DateTimeColumn get createdOn => dateTime()
      .named('createdOn')
      .clientDefault(() => DateTime.now().toUtc())
      .customConstraint("NOT NULL DEFAULT (STRFTIME('%s','now'))")();
  DateTimeColumn get updatedOn => dateTime()
      .named('updatedOn')
      .nullable()
      .clientDefault(() => DateTime.now().toUtc())();

  @override
  Set<Column> get primaryKey => {id};
}
// #endregion Sprightly tables

// #region SprightlySetup tables
@DataClassName("AppSetting")
class AppSettings extends Table {
  @override
  String get tableName => "AppSetting";

  TextColumn get name => text().named('name').withLength(max: 50)();
  TextColumn get value => text().named('value')();
  TextColumn get type => text()
      .named('type')
      .nullable()
      //.customConstraint(_typeConstraint)
      .map(
        const EnumTextConverter<PropertyType>(
          PropertyType.values,
          PropertyType.String,
        ),
      )();
  DateTimeColumn get createdOn => dateTime()
      .named('createdOn')
      .clientDefault(() => DateTime.now().toUtc())
      .customConstraint("NOT NULL DEFAULT (STRFTIME('%s','now'))")();
  DateTimeColumn get updatedOn => dateTime()
      .named('updatedOn')
      .nullable()
      .clientDefault(() => DateTime.now().toUtc())();

  @override
  Set<Column> get primaryKey => {name};

  // String get _typeConstraint =>
  //     'NULL ' + PropertyType.values.getConstraints('type');
}
// #endregion SprightlySetup tables

// #region Custom query & classes
class SprightlyQueries with ReadyOrNotMixin {
  factory SprightlyQueries() => universal;

  static SprightlyQueries universal = SprightlyQueries._();

  SprightlyQueries._() {
    getReadyWorker = _getReady;
  }

  // startup queries
  CustomQuery get defaultStartupStatement =>
      CustomQuery.fromAsset("defaultStartupStatement.sql");

  // custom queries
  // CustomQuery get selectGroupAccountMembers =>
  //     CustomQuery.fromAsset("selectGroupAccountMembers.sql");
  // CustomQuery get selectGroupOnlyMembers =>
  //     CustomQuery.fromAsset("selectGroupOnlyMembers.sql");
  // CustomQuery get selectGroupSettlements =>
  //     CustomQuery.fromAsset("selectGroupSettlements.sql");
  // CustomQuery get selectGroupTransactions =>
  //     CustomQuery.fromAsset("selectGroupTransactions.sql");

  // beforeOpen queries
  CustomQuery get dataInitiation => CustomQuery.fromAsset("dataInitiation.sql");
  CustomQuery get setupInitiation =>
      CustomQuery.fromAsset("setupInitiation.sql");

  // Migration queries
  Map<int, CustomQuery> dataMigrations = {
    // 1: CustomQuery.fromWeb("sprightly.drift_database.dataMigrationFrom1",
    //     'https://example.com/some/source/dataMigrationFrom1.sql'),
  };
  Map<int, CustomQuery> setupMigrations = {
    // 1: CustomQuery.fromWeb("sprightly.drift_database.setupMigrationFrom1",
    //     'https://example.com/some/source/setupMigrationFrom1.sql'),
  };

  Future _getReady() async {
    // Required to set `CustomQuery.sqlSourceAssetDirectory` for fetching custom
    // query files from asset
    CustomQuery.sqlSourceAssetDirectory = dbConfig.sqlSourceAsset;

    // Required for fetching file from web
    await RemoteFileCache.universal.getReady();

    // custom queries
    // await selectGroupAccountMembers.load();
    // await selectGroupOnlyMembers.load();
    // await selectGroupSettlements.load();
    // await selectGroupTransactions.load();
  }
}

mixin _GenericDaoMixin<T extends GeneratedDatabase> on DatabaseAccessor<T> {
  final _queries = SprightlyQueries.universal;

  bool get _daoMixinReady => _queries.ready;

  Future _getDaoMixinReady() async {
    await _queries.getReady();
    await customStatement(
      await _queries.defaultStartupStatement.load() ?? 'VACUUM;',
    );
  }

  Future<void> onCreate(Migrator m) async {
    await m.createAll();
  }

  Future<void> onUpgrade(Migrator m, int from, int to);
  Future<void> beforeOpen(OpeningDetails details, Migrator m);

  Future<String> _uniqueId(
    String tableName,
    List<String> items, {
    HashLibrary? hashLibrary,
    String? key,
  }) async {
    var result = '';
    var foundUnique = false;
    var attempts = 0;
    var _hashLength = dbConfig.hashedIdMinLength;
    final _hashLibrary = hashLibrary ?? HashLibrary.values.random;
    do {
      result = hashedAll(
        items,
        hashLength: _hashLength,
        library: _hashLibrary,
        key: key,
        prefixLibrary: false,
      );
      foundUnique = !await recordWithIdExists(tableName, result);
      if (foundUnique) return result;
      attempts++;
      // If a unique Id is not found in every 3 attempts, increase the hashLength
      if (attempts % 3 == 0) _hashLength++;
    } while (attempts < dbConfig.uniqueRetry && !foundUnique);
    throw TimeoutException(
      'Can not found a suitable unique Id for '
      '$tableName after $attempts attempts',
    );
  }

  Future<bool> recordWithIdExists(String tableName, String id) =>
      recordWithColumnValueExists(tableName, 'id', id);

  Future<bool> recordWithColumnValueExists(
    String tableName,
    String column,
    String value,
  ) async =>
      await customSelect(
        "SELECT COUNT(1) AS counting FROM $tableName t WHERE t.$column=:value",
        variables: [Variable.withString(value)],
      ).map((row) => row.read<int>("counting")).getSingle() >
      0;

  Selectable<QueryRow> getRecordsWithColumnValue(
    String tableName,
    String column,
    String value, {
    TableInfo? table,
  }) =>
      customSelect(
        "SELECT t.* FROM $tableName t WHERE t.$column=:value",
        variables: [Variable.withString(value)],
        readsFrom: null == table ? {} : {table},
      );

  /// **_caution_**: use this function only if the query returns only 1 record
  /// or none
  Future<Map<String, dynamic>> getRecordWithColumnValue(
    String tableName,
    String column,
    String value, {
    TableInfo? table,
  }) async =>
      (await getRecordsWithColumnValue(tableName, column, value, table: table)
              .getSingle())
          .data;

  Future<Map<String, dynamic>> getRecord(
    String tableName,
    String id, {
    TableInfo? table,
  }) async =>
      (await getRecordsWithColumnValue(tableName, 'id', id, table: table)
              .getSingle())
          .data;

  Future<bool> updateRecord<Tbl extends Table, R extends DataClass>(
    TableInfo<Tbl, R> table,
    Insertable<R> record,
  ) =>
      update(table).replace(record);

  Future<int> deleteRecord<Tbl extends Table, R extends DataClass>(
    TableInfo<Tbl, R> table,
    Insertable<R> record,
  ) =>
      delete(table).delete(record);
}
// #endregion Custom query & classes

@DriftAccessor(
  tables: _appTables,
)
class SprightlyDao extends DatabaseAccessor<SprightlyDatabase>
    with _$SprightlyDaoMixin, _GenericDaoMixin, ReadyOrNotMixin
    implements SystemDao {
  SprightlyDao(SprightlyDatabase _db) : super(_db) {
    getReadyWorker = _getReady;
  }

  @override
  bool get ready => super._daoMixinReady && super.ready;

  Future _getReady() async {
    await super._getDaoMixinReady();
    // _sharedGroupList = await getGroups(GroupType.Shared);
  }

  @override
  Future<void> onCreate(Migrator m) async {
    await super.onCreate(m);
    await super.customStatement(await _queries.dataInitiation.load() ?? '');
  }

  @override
  Future<void> onUpgrade(Migrator m, int from, int to) async {
    for (var i = from; i < to; i++) {
      await super
          .customStatement(await _queries.dataMigrations[i]!.load() ?? '');
    }
  }

  @override
  Future<void> beforeOpen(OpeningDetails details, Migrator m) async {
    await getReady();
    driftRuntimeOptions.defaultSerializer =
        const ExtendedValueSerializer(enumTypes);
    if (details.wasCreated) {
      // TODO: do first time activity
      //// creating default Group & Accounts
      // var defaultGroup = await createGroup('Sprightly Default',
      //     type: GroupType.Personal, isHidden: true);
      // await addAccount('Cash', defaultGroup.id, type: AccountType.Cash);
      // await addAccount('Bank Accounts', defaultGroup.id,
      //     type: AccountType.Bank);
      // await addAccount('Credit Cards', defaultGroup.id,
      //     type: AccountType.Credit);
      // await addAccount('Investments', defaultGroup.id,
      //     type: AccountType.Investment);
    }
  }
//
//   Future<List<Category>> getCategories() => select(categories).get();
//   Future<List<Account>> getAccounts() => select(accounts).get();
//
//   List<Group> _sharedGroupList;
//   List<Group> get sharedGroupList => _sharedGroupList;
//
//   Selectable<Member> _selectGroupAccountMembers(String groupId) => customSelect(
//         _queries.selectGroupAccountMembers.query,
//         variables: [Variable.withString(groupId)],
//         readsFrom: {members, groupMembers},
//       ).map((row) => Member.fromData(row.data, attachedDatabase));
//
//   Future<List<Member>> getGroupAccountMembers(String groupId) =>
//       _selectGroupAccountMembers(groupId).get();
//
//   Stream<List<Member>> watchGroupAccountMembers(String groupId) =>
//       _selectGroupAccountMembers(groupId).watch();
//
//   Selectable<Member> _selectGroupOnlyMembers(String groupId) => customSelect(
//         _queries.selectGroupOnlyMembers.query,
//         variables: [Variable.withString(groupId)],
//         readsFrom: {members, groupMembers},
//       ).map((row) => Member.fromData(row.data, attachedDatabase));
//
//   Future<List<Member>> getGroupOnlyMembers(String groupId) =>
//       _selectGroupOnlyMembers(groupId).get();
//
//   Stream<List<Member>> watchGroupOnlyMembers(String groupId) =>
//       _selectGroupOnlyMembers(groupId).watch();
//
//   Future<bool> memberWithNameExists(String name) =>
//       recordWithColumnValueExists(members.actualTableName, 'name', name);

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
    final _id = id ?? await _uniqueId(members.actualTableName, [idValue]);
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

//   Future<Member> addGroupMember(String groupId, String idValue,
//       {String id,
//       String name,
//       String nickName,
//       String avatar,
//       MemberIdType idType = MemberIdType.GroupMember,
//       String secondaryIdValue,
//       bool isGroupExpense = false,
//       String signature}) async {
//     Member member;
//     var existingMember = false;
//     if (null != id) {
//       if (await recordWithIdExists(members.actualTableName, id)) {
//         member = await getMember(id);
//         existingMember = true;
//       }
//     }
//
//     if (!existingMember) {
//       if (idType == MemberIdType.Group) isGroupExpense = true;
//
//       member = await addMember(idValue,
//           id: id,
//           name: name,
//           nickName: nickName,
//           avatar: avatar,
//           idType: idType,
//           secondaryIdValue: secondaryIdValue,
//           isGroupExpense: isGroupExpense,
//           signature: signature);
//
//       if (idType == MemberIdType.Group)
//         await addAccount(idValue, groupId,
//             memberId: member.id, type: AccountType.Group);
//     }
//     var groupMembersComp =
//         GroupMembersCompanion.insert(groupId: groupId, memberId: member.id);
//     await into(groupMembers).insert(groupMembersComp);
//     return member;
//   }

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

//   Future<int> deleteMemberFromGroup(String memberId, String groupId) async {
//     var groupMember = await (select(groupMembers)
//           ..where((gm) =>
//               gm.groupId.equals(groupId) & gm.memberId.equals(memberId)))
//         .getSingle();
//     return deleteRecord(groupMembers, groupMember);
//   }
//
//   Selectable<Settlement> _selectGroupSettlements(String groupId,
//           {bool isTemporary}) =>
//       customSelect(
//         _queries.selectGroupSettlements.query,
//         variables: [
//           Variable.withString(groupId),
//           Variable.withBool(isTemporary)
//         ],
//         readsFrom: {settlements, groups},
//       ).map((row) => Settlement.fromData(row.data, attachedDatabase));
//
//   Future<List<Settlement>> getGroupSettlements(String groupId,
//           {bool isTemporary}) =>
//       _selectGroupSettlements(groupId, isTemporary: isTemporary).get();
//
//   Stream<List<Settlement>> watchGroupSettlements(String groupId,
//           {bool isTemporary}) =>
//       _selectGroupSettlements(groupId, isTemporary: isTemporary).watch();
//
//   Future<Settlement> getSettlement(String settlementId) async =>
//       Settlement.fromJson(
//           await getRecord(settlements.actualTableName, settlementId));
//
//   Future<Settlement> newSettlementForGroup(
//     String groupId,
//     String fromMemberId,
//     String toMemberId,
//     double amount, {
//     String id,
//     double settledAmount,
//     bool isTemporary = true,
//     String transactionId,
//     String signature,
//   }) async {
//     if (null == id) {
//       id = await _uniqueId(settlements.actualTableName,
//           [groupId, fromMemberId, toMemberId, amount.toString()],
//           hashLibrary: HashLibrary.hmac_sha256);
//     }
//     return Settlement(
//         id: id,
//         groupId: groupId,
//         fromMemberId: fromMemberId,
//         toMemberId: toMemberId,
//         amount: amount,
//         settledAmount: settledAmount,
//         isTemporary: isTemporary,
//         transactionId: transactionId,
//         signature: signature,
//         createdOn: DateTime.now().toUtc(),
//         updatedOn: DateTime.now().toUtc());
//   }
//
//   Future<void> addGroupSettlements(
//           String groupId, List<Settlement> settlementList) =>
//       batch((b) => b.insertAll(settlements, settlementList));
//
//   Future<bool> finalizeSettlement(
//     String groupId,
//     String id,
//     String signature, {
//     double settledAmount,
//     String notes,
//     List<String> attachments,
//     List<String> tags,
//     DateTime doneOn,
//   }) async {
//     var recordExists =
//         await recordWithIdExists(settlements.actualTableName, id);
//     if (recordExists) {
//       var settleMent = await getSettlement(id);
//       var transaction = await addGroupTransaction(
//         groupId,
//         settleMent.fromMemberId,
//         settledAmount ?? settleMent.amount,
//         groupMemberIds: settleMent.toMemberId,
//         settlementId: settleMent.id,
//         notes: notes,
//         attachments: attachments,
//         tags: tags,
//         doneOn: doneOn,
//       );
//       settleMent.copyWith(
//         settledAmount: settledAmount,
//         isTemporary: false,
//         transactionId: transaction.id,
//         signature: signature,
//         updatedOn: DateTime.now().toUtc(),
//       );
//       return updateRecord(settlements, settleMent);
//     }
//     return false;
//   }
//
//   Future<int> deleteTempSettlements(String groupId) =>
//       transaction(() => (delete(settlements)
//             ..where(
//                 (s) => s.groupId.equals(groupId) & s.isTemporary.equals(true)))
//           .go());
//
//   Selectable<Transaction> _selectGroupTransactions(String groupId) =>
//       customSelect(
//         _queries.selectGroupTransactions.query,
//         variables: [Variable.withString(groupId)],
//         readsFrom: {transactions, groups},
//       ).map((row) => Transaction.fromData(row.data, attachedDatabase));
//
//   Future<List<Transaction>> getGroupTransactions(String groupId) =>
//       _selectGroupTransactions(groupId).get();
//
//   Stream<List<Transaction>> watchGroupTransactions(String groupId) =>
//       _selectGroupTransactions(groupId).watch();
//
//   Future<Transaction> getTransaction(String transactionId) async =>
//       Transaction.fromJson(
//           await getRecord(transactions.actualTableName, transactionId));
//
//   Future<Transaction> addGroupTransaction(
//     String groupId,
//     String memberId,
//     double amount, {
//     String id,
//     String groupMemberIds,
//     int fromAccountId,
//     int toAccountId,
//     int categoryId,
//     String settlementId,
//     String notes,
//     List<String> attachments,
//     List<String> tags,
//     DateTime doneOn,
//   }) async {
//     if (null != id)
//       id = await _uniqueId(
//           transactions.actualTableName, [groupId, memberId, amount.toString()],
//           hashLibrary: HashLibrary.hmac_sha256);
//     var transactionComp = TransactionsCompanion.insert(
//       id: id,
//       memberId: memberId,
//       amount: amount,
//       groupId: groupId,
//       groupMemberIds: Value(groupMemberIds),
//       fromAccountId: Value(fromAccountId),
//       toAccountId: Value(toAccountId),
//       categoryId: Value(categoryId),
//       settlementId: Value(settlementId),
//       notes: Value(notes),
//       attachments: Value(attachments.join(',')),
//       tags: Value(tags.join(',')),
//       doneOn: Value(doneOn ?? DateTime.now().toUtc()),
//     );
//     into(transactions).insert(transactionComp);
//     return getTransaction(id);
//   }
//
//   Future<Transaction> updateTransaction(
//     String transactionId, {
//     String memberId,
//     double amount,
//     String groupMemberIds,
//     int fromAccountId,
//     int toAccountId,
//     int categoryId,
//     String notes,
//     List<String> attachments,
//     List<String> tags,
//     DateTime doneOn,
//   }) async {
//     var transaction = await getTransaction(transactionId);
//     if (null == transaction.settlementId) {
//       transaction.copyWith(
//         memberId: memberId,
//         amount: amount,
//         groupMemberIds: groupMemberIds,
//         fromAccountId: fromAccountId,
//         toAccountId: toAccountId,
//         categoryId: categoryId,
//         notes: notes,
//         attachments: attachments.join(','),
//         tags: tags.join(','),
//         doneOn: doneOn,
//         updatedOn: DateTime.now().toUtc(),
//       );
//       await updateRecord(transactions, transaction);
//       return getTransaction(transactionId);
//     }
//     return transaction;
//   }
//
//   Future<int> deleteTransaction(String transactionId) async {
//     var transaction = await getTransaction(transactionId);
//     if (null == transaction.settlementId)
//       return deleteRecord(
//           transactions, TransactionsCompanion(id: Value(transactionId)));
//     return 0;
//   }
//
//   Future<Account> getAccount(int accountId) async => Account.fromJson(
//       await getRecord(accounts.actualTableName, accountId.toString()));
//
//   Future<Account> addAccount(String name, String groupId,
//       {int parentId, AccountType type, String memberId, double balance}) async {
//     var accountsComp = AccountsCompanion.insert(
//       name: name,
//       groupId: groupId,
//       parentId: Value(parentId),
//       type: Value(type),
//       memberId: Value(memberId),
//       balance: Value(balance),
//     );
//     var accountId = await into(accounts).insert(accountsComp);
//     return getAccount(accountId);
//   }
//
//   Future<Account> updateAccount(int accountId,
//       {String name,
//       String groupId,
//       int parentId,
//       AccountType type,
//       String memberId,
//       double balance}) async {
//     var account = await getAccount(accountId);
//     account.copyWith(
//       name: name,
//       groupId: groupId,
//       parentId: parentId,
//       type: type,
//       memberId: memberId,
//       balance: balance,
//       updatedOn: DateTime.now().toUtc(),
//     );
//     await updateRecord(accounts, account);
//     return getAccount(accountId);
//   }
//
//   Future<int> deleteAccount(int accountId) =>
//       deleteRecord(accounts, AccountsCompanion(id: Value(accountId)));
//
//   Selectable<Group> _selectGroupBy(
//     String column,
//     String value,
//   ) =>
//       getRecordsWithColumnValue(
//         groups.actualTableName,
//         column,
//         value,
//         table: groups,
//       ).map((row) => Group.fromData(row.data, attachedDatabase));
//
//   Future<List<Group>> getGroups(GroupType type) async =>
//       await _selectGroupBy('type', type.toEnumString()).get();
//
//   Stream<List<Group>> watchGroups(GroupType type) =>
//       _selectGroupBy('type', type.toEnumString()).watch();
//
//   Future<bool> groupWithNameExists(String groupName) =>
//       recordWithColumnValueExists(groups.actualTableName, 'name', groupName);
//
//   Future<Group> getGroup(String groupId) async =>
//       Group.fromJson(await getRecord(groups.actualTableName, groupId));
//
//   Future<Group> createGroup(String name,
//       {GroupType type = GroupType.Shared, bool isHidden = false}) async {
//     var groupId =
//         await _uniqueId(groups.actualTableName, [name, type.toEnumString()]);
//     var newGroupComp = GroupsCompanion.insert(
//       id: groupId,
//       name: name,
//       type: Value(type),
//       isHidden: Value(isHidden),
//     );
//     await into(groups).insert(newGroupComp);
//     var newGroup = await getGroup(groupId);
//     if (type == GroupType.Shared) _sharedGroupList.add(newGroup);
//     return newGroup;
//   }
//
//   Future<Group> updateGroup(String groupId,
//       {String name, GroupType type, bool isHidden}) async {
//     var group = await getGroup(groupId);
//     group.copyWith(
//       name: name,
//       type: type,
//       isHidden: isHidden,
//       updatedOn: DateTime.now().toUtc(),
//     );
//     await updateRecord(groups, group);
//     if (type == GroupType.Shared)
//       _sharedGroupList = await getGroups(GroupType.Shared);
//     return getGroup(groupId);
//   }
//
//   Future<int> deleteGroup(String groupId) async {
//     var result =
//         await deleteRecord(groups, GroupsCompanion(id: Value(groupId)));
//     _sharedGroupList = await getGroups(GroupType.Shared);
//     return result;
//   }
}

@DriftAccessor(
  tables: _setupTables,
)
class SprightlySetupDao extends DatabaseAccessor<SprightlySetupDatabase>
    with _$SprightlySetupDaoMixin, _GenericDaoMixin, ReadyOrNotMixin
    implements SettingsDao {
  SprightlySetupDao(SprightlySetupDatabase _db) : super(_db) {
    getReadyWorker = _getReady;
  }

  @override
  bool get ready =>
      super._daoMixinReady && _appInformation.ready && super.ready;

  Future _getReady() async {
    await super._getDaoMixinReady();
    await _appInformation.getReady();
    _allAppSettings = await getAppSettings();
    // _allAppFonts = await getAppFonts();
    // _allFontCombos = await getFontCombos();
    // _allColorCombos = await getColorCombos();
  }

  @override
  Future<void> onCreate(Migrator m) async {
    await super.onCreate(m);
    await super.customStatement(await _queries.setupInitiation.load() ?? '');
  }

  @override
  Future<void> onUpgrade(Migrator m, int from, int to) async {
    for (var i = from; i < to; i++) {
      await super
          .customStatement(await _queries.setupMigrations[i]?.load() ?? '');
    }
  }

  @override
  Future<void> beforeOpen(OpeningDetails details, Migrator m) async {
    await getReady();
    driftRuntimeOptions.defaultSerializer =
        const ExtendedValueSerializer(enumTypes);
    if (details.wasCreated) {
      // TODO: do first time activity
      // already done through _queries.setupInitiation
    }
    if (details.wasCreated || details.hadUpgrade) {
      // sync dbVersion
      await updateAppSetting(
        'dbVersion',
        attachedDatabase.schemaVersion.toString(),
      );
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

LazyDatabase _openConnection(
  String dbFile, {
  bool? isSupportFile,
  bool? logStatements,
  bool? recreateDatabase,
  DatabaseSetup? setup,
}) =>
    LazyDatabase(
      () async => NativeDatabase(
        await getFile(
          dbFile,
          isSupportFile: isSupportFile ?? false,
          recreateFile: recreateDatabase ?? false,
        ),
        logStatements: logStatements ?? false,
        setup: setup,
      ),
    );

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
          _openConnection(
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
          _openConnection(
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
