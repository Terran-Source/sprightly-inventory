import 'package:dart_marganam/extensions.dart' show EnumTextConverter;
import 'package:drift/drift.dart';
import 'package:sprightly_inventory/core/config/enums.dart';

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
