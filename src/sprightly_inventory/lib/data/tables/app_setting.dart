import 'package:dart_marganam/extensions/drift/enum_converter.dart';
import 'package:drift/drift.dart';
import 'package:sprightly_inventory/core/config/enums.dart';

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
