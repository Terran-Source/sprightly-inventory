import 'package:dart_marganam/extensions.dart' show EnumTextConverter;
import 'package:drift/drift.dart';
import 'package:sprightly_inventory/core/config/enums.dart';

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
