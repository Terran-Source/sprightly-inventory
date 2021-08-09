// GENERATED CODE - DO NOT MODIFY BY HAND

part of sprightly.moor_database;

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String name;
  final String value;
  final AppSettingType? type;
  final DateTime createdOn;
  final DateTime? updatedOn;
  AppSetting(
      {required this.name,
      required this.value,
      this.type,
      required this.createdOn,
      this.updatedOn});
  factory AppSetting.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return AppSetting(
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      value: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
      type: $AppSettingsTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])),
      createdOn: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}createdOn'])!,
      updatedOn: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updatedOn']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['value'] = Variable<String>(value);
    if (!nullToAbsent || type != null) {
      final converter = $AppSettingsTable.$converter0;
      map['type'] = Variable<String?>(converter.mapToSql(type));
    }
    map['createdOn'] = Variable<DateTime>(createdOn);
    if (!nullToAbsent || updatedOn != null) {
      map['updatedOn'] = Variable<DateTime?>(updatedOn);
    }
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      name: Value(name),
      value: Value(value),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      createdOn: Value(createdOn),
      updatedOn: updatedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedOn),
    );
  }

  factory AppSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return AppSetting(
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<String>(json['value']),
      type: serializer.fromJson<AppSettingType?>(json['type']),
      createdOn: serializer.fromJson<DateTime>(json['createdOn']),
      updatedOn: serializer.fromJson<DateTime?>(json['updatedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<String>(value),
      'type': serializer.toJson<AppSettingType?>(type),
      'createdOn': serializer.toJson<DateTime>(createdOn),
      'updatedOn': serializer.toJson<DateTime?>(updatedOn),
    };
  }

  AppSetting copyWith(
          {String? name,
          String? value,
          AppSettingType? type,
          DateTime? createdOn,
          DateTime? updatedOn}) =>
      AppSetting(
        name: name ?? this.name,
        value: value ?? this.value,
        type: type ?? this.type,
        createdOn: createdOn ?? this.createdOn,
        updatedOn: updatedOn ?? this.updatedOn,
      );
  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('type: $type, ')
          ..write('createdOn: $createdOn, ')
          ..write('updatedOn: $updatedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      name.hashCode,
      $mrjc(
          value.hashCode,
          $mrjc(
              type.hashCode, $mrjc(createdOn.hashCode, updatedOn.hashCode)))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.name == this.name &&
          other.value == this.value &&
          other.type == this.type &&
          other.createdOn == this.createdOn &&
          other.updatedOn == this.updatedOn);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> name;
  final Value<String> value;
  final Value<AppSettingType?> type;
  final Value<DateTime> createdOn;
  final Value<DateTime?> updatedOn;
  const AppSettingsCompanion({
    this.name = const Value.absent(),
    this.value = const Value.absent(),
    this.type = const Value.absent(),
    this.createdOn = const Value.absent(),
    this.updatedOn = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String name,
    required String value,
    this.type = const Value.absent(),
    this.createdOn = const Value.absent(),
    this.updatedOn = const Value.absent(),
  })  : name = Value(name),
        value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<String>? name,
    Expression<String>? value,
    Expression<AppSettingType?>? type,
    Expression<DateTime>? createdOn,
    Expression<DateTime?>? updatedOn,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (value != null) 'value': value,
      if (type != null) 'type': type,
      if (createdOn != null) 'createdOn': createdOn,
      if (updatedOn != null) 'updatedOn': updatedOn,
    });
  }

  AppSettingsCompanion copyWith(
      {Value<String>? name,
      Value<String>? value,
      Value<AppSettingType?>? type,
      Value<DateTime>? createdOn,
      Value<DateTime?>? updatedOn}) {
    return AppSettingsCompanion(
      name: name ?? this.name,
      value: value ?? this.value,
      type: type ?? this.type,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (type.present) {
      final converter = $AppSettingsTable.$converter0;
      map['type'] = Variable<String?>(converter.mapToSql(type.value));
    }
    if (createdOn.present) {
      map['createdOn'] = Variable<DateTime>(createdOn.value);
    }
    if (updatedOn.present) {
      map['updatedOn'] = Variable<DateTime?>(updatedOn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('type: $type, ')
          ..write('createdOn: $createdOn, ')
          ..write('updatedOn: $updatedOn')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  final GeneratedDatabase _db;
  final String? _alias;
  $AppSettingsTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  late final GeneratedColumn<String?> value = GeneratedColumn<String?>(
      'value', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumnWithTypeConverter<AppSettingType, String?> type =
      GeneratedColumn<String?>('type', aliasedName, true,
              typeName: 'TEXT', requiredDuringInsert: false)
          .withConverter<AppSettingType>($AppSettingsTable.$converter0);
  final VerificationMeta _createdOnMeta = const VerificationMeta('createdOn');
  late final GeneratedColumn<DateTime?> createdOn = GeneratedColumn<DateTime?>(
      'createdOn', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (STRFTIME(\'%s\',\'now\'))',
      clientDefault: () => DateTime.now().toUtc());
  final VerificationMeta _updatedOnMeta = const VerificationMeta('updatedOn');
  late final GeneratedColumn<DateTime?> updatedOn = GeneratedColumn<DateTime?>(
      'updatedOn', aliasedName, true,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  @override
  List<GeneratedColumn> get $columns =>
      [name, value, type, createdOn, updatedOn];
  @override
  String get aliasedName => _alias ?? 'AppSetting';
  @override
  String get actualTableName => 'AppSetting';
  @override
  VerificationContext validateIntegrity(Insertable<AppSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('createdOn')) {
      context.handle(_createdOnMeta,
          createdOn.isAcceptableOrUnknown(data['createdOn']!, _createdOnMeta));
    }
    if (data.containsKey('updatedOn')) {
      context.handle(_updatedOnMeta,
          updatedOn.isAcceptableOrUnknown(data['updatedOn']!, _updatedOnMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    return AppSetting.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(_db, alias);
  }

  static TypeConverter<AppSettingType, String> $converter0 =
      const EnumTypeConverter<AppSettingType>(
          AppSettingType.values, AppSettingType.String);
}

abstract class _$SprightlySetupDatabase extends GeneratedDatabase {
  _$SprightlySetupDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final SprightlySetupDao sprightlySetupDao =
      SprightlySetupDao(this as SprightlySetupDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [appSettings];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$SprightlySetupDaoMixin on DatabaseAccessor<SprightlySetupDatabase> {
  $AppSettingsTable get appSettings => attachedDatabase.appSettings;
}
