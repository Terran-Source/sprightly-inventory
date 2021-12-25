// GENERATED CODE - DO NOT MODIFY BY HAND

part of sprightly.drift_database;

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Member extends DataClass implements Insertable<Member> {
  final String id;
  final String name;
  final String? avatar;
  final MemberIdType? idType;
  final String? idValue;
  final String? signature;
  final DateTime createdOn;
  final DateTime? updatedOn;
  Member(
      {required this.id,
      required this.name,
      this.avatar,
      this.idType,
      this.idValue,
      this.signature,
      required this.createdOn,
      this.updatedOn});
  factory Member.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Member(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      avatar: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}avatar']),
      idType: $MembersTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}idType'])),
      idValue: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}idValue']),
      signature: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}signature']),
      createdOn: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}createdOn'])!,
      updatedOn: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updatedOn']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String?>(avatar);
    }
    if (!nullToAbsent || idType != null) {
      final converter = $MembersTable.$converter0;
      map['idType'] = Variable<String?>(converter.mapToSql(idType));
    }
    if (!nullToAbsent || idValue != null) {
      map['idValue'] = Variable<String?>(idValue);
    }
    if (!nullToAbsent || signature != null) {
      map['signature'] = Variable<String?>(signature);
    }
    map['createdOn'] = Variable<DateTime>(createdOn);
    if (!nullToAbsent || updatedOn != null) {
      map['updatedOn'] = Variable<DateTime?>(updatedOn);
    }
    return map;
  }

  MembersCompanion toCompanion(bool nullToAbsent) {
    return MembersCompanion(
      id: Value(id),
      name: Value(name),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      idType:
          idType == null && nullToAbsent ? const Value.absent() : Value(idType),
      idValue: idValue == null && nullToAbsent
          ? const Value.absent()
          : Value(idValue),
      signature: signature == null && nullToAbsent
          ? const Value.absent()
          : Value(signature),
      createdOn: Value(createdOn),
      updatedOn: updatedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedOn),
    );
  }

  factory Member.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Member(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      idType: serializer.fromJson<MemberIdType?>(json['idType']),
      idValue: serializer.fromJson<String?>(json['idValue']),
      signature: serializer.fromJson<String?>(json['signature']),
      createdOn: serializer.fromJson<DateTime>(json['createdOn']),
      updatedOn: serializer.fromJson<DateTime?>(json['updatedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'avatar': serializer.toJson<String?>(avatar),
      'idType': serializer.toJson<MemberIdType?>(idType),
      'idValue': serializer.toJson<String?>(idValue),
      'signature': serializer.toJson<String?>(signature),
      'createdOn': serializer.toJson<DateTime>(createdOn),
      'updatedOn': serializer.toJson<DateTime?>(updatedOn),
    };
  }

  Member copyWith(
          {String? id,
          String? name,
          String? avatar,
          MemberIdType? idType,
          String? idValue,
          String? signature,
          DateTime? createdOn,
          DateTime? updatedOn}) =>
      Member(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        idType: idType ?? this.idType,
        idValue: idValue ?? this.idValue,
        signature: signature ?? this.signature,
        createdOn: createdOn ?? this.createdOn,
        updatedOn: updatedOn ?? this.updatedOn,
      );
  @override
  String toString() {
    return (StringBuffer('Member(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('idType: $idType, ')
          ..write('idValue: $idValue, ')
          ..write('signature: $signature, ')
          ..write('createdOn: $createdOn, ')
          ..write('updatedOn: $updatedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, avatar, idType, idValue, signature, createdOn, updatedOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Member &&
          other.id == this.id &&
          other.name == this.name &&
          other.avatar == this.avatar &&
          other.idType == this.idType &&
          other.idValue == this.idValue &&
          other.signature == this.signature &&
          other.createdOn == this.createdOn &&
          other.updatedOn == this.updatedOn);
}

class MembersCompanion extends UpdateCompanion<Member> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> avatar;
  final Value<MemberIdType?> idType;
  final Value<String?> idValue;
  final Value<String?> signature;
  final Value<DateTime> createdOn;
  final Value<DateTime?> updatedOn;
  const MembersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.avatar = const Value.absent(),
    this.idType = const Value.absent(),
    this.idValue = const Value.absent(),
    this.signature = const Value.absent(),
    this.createdOn = const Value.absent(),
    this.updatedOn = const Value.absent(),
  });
  MembersCompanion.insert({
    required String id,
    required String name,
    this.avatar = const Value.absent(),
    this.idType = const Value.absent(),
    this.idValue = const Value.absent(),
    this.signature = const Value.absent(),
    this.createdOn = const Value.absent(),
    this.updatedOn = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Member> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String?>? avatar,
    Expression<MemberIdType?>? idType,
    Expression<String?>? idValue,
    Expression<String?>? signature,
    Expression<DateTime>? createdOn,
    Expression<DateTime?>? updatedOn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (avatar != null) 'avatar': avatar,
      if (idType != null) 'idType': idType,
      if (idValue != null) 'idValue': idValue,
      if (signature != null) 'signature': signature,
      if (createdOn != null) 'createdOn': createdOn,
      if (updatedOn != null) 'updatedOn': updatedOn,
    });
  }

  MembersCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? avatar,
      Value<MemberIdType?>? idType,
      Value<String?>? idValue,
      Value<String?>? signature,
      Value<DateTime>? createdOn,
      Value<DateTime?>? updatedOn}) {
    return MembersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      idType: idType ?? this.idType,
      idValue: idValue ?? this.idValue,
      signature: signature ?? this.signature,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String?>(avatar.value);
    }
    if (idType.present) {
      final converter = $MembersTable.$converter0;
      map['idType'] = Variable<String?>(converter.mapToSql(idType.value));
    }
    if (idValue.present) {
      map['idValue'] = Variable<String?>(idValue.value);
    }
    if (signature.present) {
      map['signature'] = Variable<String?>(signature.value);
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
    return (StringBuffer('MembersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('idType: $idType, ')
          ..write('idValue: $idValue, ')
          ..write('signature: $signature, ')
          ..write('createdOn: $createdOn, ')
          ..write('updatedOn: $updatedOn')
          ..write(')'))
        .toString();
  }
}

class $MembersTable extends Members with TableInfo<$MembersTable, Member> {
  final GeneratedDatabase _db;
  final String? _alias;
  $MembersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id =
      GeneratedColumn<String?>('id', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 16,
          ),
          type: const StringType(),
          requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String?> avatar = GeneratedColumn<String?>(
      'avatar', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _idTypeMeta = const VerificationMeta('idType');
  @override
  late final GeneratedColumnWithTypeConverter<MemberIdType, String?> idType =
      GeneratedColumn<String?>('idType', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<MemberIdType>($MembersTable.$converter0);
  final VerificationMeta _idValueMeta = const VerificationMeta('idValue');
  @override
  late final GeneratedColumn<String?> idValue = GeneratedColumn<String?>(
      'idValue', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _signatureMeta = const VerificationMeta('signature');
  @override
  late final GeneratedColumn<String?> signature = GeneratedColumn<String?>(
      'signature', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _createdOnMeta = const VerificationMeta('createdOn');
  @override
  late final GeneratedColumn<DateTime?> createdOn = GeneratedColumn<DateTime?>(
      'createdOn', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (STRFTIME(\'%s\',\'now\'))',
      clientDefault: () => DateTime.now().toUtc());
  final VerificationMeta _updatedOnMeta = const VerificationMeta('updatedOn');
  @override
  late final GeneratedColumn<DateTime?> updatedOn = GeneratedColumn<DateTime?>(
      'updatedOn', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, avatar, idType, idValue, signature, createdOn, updatedOn];
  @override
  String get aliasedName => _alias ?? 'Member';
  @override
  String get actualTableName => 'Member';
  @override
  VerificationContext validateIntegrity(Insertable<Member> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta));
    }
    context.handle(_idTypeMeta, const VerificationResult.success());
    if (data.containsKey('idValue')) {
      context.handle(_idValueMeta,
          idValue.isAcceptableOrUnknown(data['idValue']!, _idValueMeta));
    }
    if (data.containsKey('signature')) {
      context.handle(_signatureMeta,
          signature.isAcceptableOrUnknown(data['signature']!, _signatureMeta));
    }
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Member map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Member.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MembersTable createAlias(String alias) {
    return $MembersTable(_db, alias);
  }

  static TypeConverter<MemberIdType, String> $converter0 =
      const EnumTextConverter<MemberIdType>(MemberIdType.values);
}

class CustomProperty extends DataClass implements Insertable<CustomProperty> {
  final String id;
  final String parent;
  final String parentId;
  final PropertyType propertyType;
  final String name;
  final DateTime createdOn;
  final DateTime? updatedOn;
  CustomProperty(
      {required this.id,
      required this.parent,
      required this.parentId,
      required this.propertyType,
      required this.name,
      required this.createdOn,
      this.updatedOn});
  factory CustomProperty.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CustomProperty(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      parent: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}parent'])!,
      parentId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}parentId'])!,
      propertyType: $CustomPropertiesTable.$converter0.mapToDart(
          const StringType().mapFromDatabaseResponse(
              data['${effectivePrefix}propertyType']))!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      createdOn: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}createdOn'])!,
      updatedOn: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updatedOn']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['parent'] = Variable<String>(parent);
    map['parentId'] = Variable<String>(parentId);
    {
      final converter = $CustomPropertiesTable.$converter0;
      map['propertyType'] = Variable<String>(converter.mapToSql(propertyType)!);
    }
    map['name'] = Variable<String>(name);
    map['createdOn'] = Variable<DateTime>(createdOn);
    if (!nullToAbsent || updatedOn != null) {
      map['updatedOn'] = Variable<DateTime?>(updatedOn);
    }
    return map;
  }

  CustomPropertiesCompanion toCompanion(bool nullToAbsent) {
    return CustomPropertiesCompanion(
      id: Value(id),
      parent: Value(parent),
      parentId: Value(parentId),
      propertyType: Value(propertyType),
      name: Value(name),
      createdOn: Value(createdOn),
      updatedOn: updatedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedOn),
    );
  }

  factory CustomProperty.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomProperty(
      id: serializer.fromJson<String>(json['id']),
      parent: serializer.fromJson<String>(json['parent']),
      parentId: serializer.fromJson<String>(json['parentId']),
      propertyType: serializer.fromJson<PropertyType>(json['propertyType']),
      name: serializer.fromJson<String>(json['name']),
      createdOn: serializer.fromJson<DateTime>(json['createdOn']),
      updatedOn: serializer.fromJson<DateTime?>(json['updatedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'parent': serializer.toJson<String>(parent),
      'parentId': serializer.toJson<String>(parentId),
      'propertyType': serializer.toJson<PropertyType>(propertyType),
      'name': serializer.toJson<String>(name),
      'createdOn': serializer.toJson<DateTime>(createdOn),
      'updatedOn': serializer.toJson<DateTime?>(updatedOn),
    };
  }

  CustomProperty copyWith(
          {String? id,
          String? parent,
          String? parentId,
          PropertyType? propertyType,
          String? name,
          DateTime? createdOn,
          DateTime? updatedOn}) =>
      CustomProperty(
        id: id ?? this.id,
        parent: parent ?? this.parent,
        parentId: parentId ?? this.parentId,
        propertyType: propertyType ?? this.propertyType,
        name: name ?? this.name,
        createdOn: createdOn ?? this.createdOn,
        updatedOn: updatedOn ?? this.updatedOn,
      );
  @override
  String toString() {
    return (StringBuffer('CustomProperty(')
          ..write('id: $id, ')
          ..write('parent: $parent, ')
          ..write('parentId: $parentId, ')
          ..write('propertyType: $propertyType, ')
          ..write('name: $name, ')
          ..write('createdOn: $createdOn, ')
          ..write('updatedOn: $updatedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, parent, parentId, propertyType, name, createdOn, updatedOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomProperty &&
          other.id == this.id &&
          other.parent == this.parent &&
          other.parentId == this.parentId &&
          other.propertyType == this.propertyType &&
          other.name == this.name &&
          other.createdOn == this.createdOn &&
          other.updatedOn == this.updatedOn);
}

class CustomPropertiesCompanion extends UpdateCompanion<CustomProperty> {
  final Value<String> id;
  final Value<String> parent;
  final Value<String> parentId;
  final Value<PropertyType> propertyType;
  final Value<String> name;
  final Value<DateTime> createdOn;
  final Value<DateTime?> updatedOn;
  const CustomPropertiesCompanion({
    this.id = const Value.absent(),
    this.parent = const Value.absent(),
    this.parentId = const Value.absent(),
    this.propertyType = const Value.absent(),
    this.name = const Value.absent(),
    this.createdOn = const Value.absent(),
    this.updatedOn = const Value.absent(),
  });
  CustomPropertiesCompanion.insert({
    required String id,
    required String parent,
    required String parentId,
    required PropertyType propertyType,
    required String name,
    this.createdOn = const Value.absent(),
    this.updatedOn = const Value.absent(),
  })  : id = Value(id),
        parent = Value(parent),
        parentId = Value(parentId),
        propertyType = Value(propertyType),
        name = Value(name);
  static Insertable<CustomProperty> custom({
    Expression<String>? id,
    Expression<String>? parent,
    Expression<String>? parentId,
    Expression<PropertyType>? propertyType,
    Expression<String>? name,
    Expression<DateTime>? createdOn,
    Expression<DateTime?>? updatedOn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parent != null) 'parent': parent,
      if (parentId != null) 'parentId': parentId,
      if (propertyType != null) 'propertyType': propertyType,
      if (name != null) 'name': name,
      if (createdOn != null) 'createdOn': createdOn,
      if (updatedOn != null) 'updatedOn': updatedOn,
    });
  }

  CustomPropertiesCompanion copyWith(
      {Value<String>? id,
      Value<String>? parent,
      Value<String>? parentId,
      Value<PropertyType>? propertyType,
      Value<String>? name,
      Value<DateTime>? createdOn,
      Value<DateTime?>? updatedOn}) {
    return CustomPropertiesCompanion(
      id: id ?? this.id,
      parent: parent ?? this.parent,
      parentId: parentId ?? this.parentId,
      propertyType: propertyType ?? this.propertyType,
      name: name ?? this.name,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (parent.present) {
      map['parent'] = Variable<String>(parent.value);
    }
    if (parentId.present) {
      map['parentId'] = Variable<String>(parentId.value);
    }
    if (propertyType.present) {
      final converter = $CustomPropertiesTable.$converter0;
      map['propertyType'] =
          Variable<String>(converter.mapToSql(propertyType.value)!);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
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
    return (StringBuffer('CustomPropertiesCompanion(')
          ..write('id: $id, ')
          ..write('parent: $parent, ')
          ..write('parentId: $parentId, ')
          ..write('propertyType: $propertyType, ')
          ..write('name: $name, ')
          ..write('createdOn: $createdOn, ')
          ..write('updatedOn: $updatedOn')
          ..write(')'))
        .toString();
  }
}

class $CustomPropertiesTable extends CustomProperties
    with TableInfo<$CustomPropertiesTable, CustomProperty> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CustomPropertiesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id =
      GeneratedColumn<String?>('id', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 16,
          ),
          type: const StringType(),
          requiredDuringInsert: true);
  final VerificationMeta _parentMeta = const VerificationMeta('parent');
  @override
  late final GeneratedColumn<String?> parent =
      GeneratedColumn<String?>('parent', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 50,
          ),
          type: const StringType(),
          requiredDuringInsert: true);
  final VerificationMeta _parentIdMeta = const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<String?> parentId =
      GeneratedColumn<String?>('parentId', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 16,
          ),
          type: const StringType(),
          requiredDuringInsert: true);
  final VerificationMeta _propertyTypeMeta =
      const VerificationMeta('propertyType');
  @override
  late final GeneratedColumnWithTypeConverter<PropertyType, String?>
      propertyType = GeneratedColumn<String?>(
              'propertyType', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<PropertyType>($CustomPropertiesTable.$converter0);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 250),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _createdOnMeta = const VerificationMeta('createdOn');
  @override
  late final GeneratedColumn<DateTime?> createdOn = GeneratedColumn<DateTime?>(
      'createdOn', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (STRFTIME(\'%s\',\'now\'))',
      clientDefault: () => DateTime.now().toUtc());
  final VerificationMeta _updatedOnMeta = const VerificationMeta('updatedOn');
  @override
  late final GeneratedColumn<DateTime?> updatedOn = GeneratedColumn<DateTime?>(
      'updatedOn', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  @override
  List<GeneratedColumn> get $columns =>
      [id, parent, parentId, propertyType, name, createdOn, updatedOn];
  @override
  String get aliasedName => _alias ?? 'CustomProperty';
  @override
  String get actualTableName => 'CustomProperty';
  @override
  VerificationContext validateIntegrity(Insertable<CustomProperty> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('parent')) {
      context.handle(_parentMeta,
          parent.isAcceptableOrUnknown(data['parent']!, _parentMeta));
    } else if (isInserting) {
      context.missing(_parentMeta);
    }
    if (data.containsKey('parentId')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parentId']!, _parentIdMeta));
    } else if (isInserting) {
      context.missing(_parentIdMeta);
    }
    context.handle(_propertyTypeMeta, const VerificationResult.success());
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomProperty map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CustomProperty.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CustomPropertiesTable createAlias(String alias) {
    return $CustomPropertiesTable(_db, alias);
  }

  static TypeConverter<PropertyType, String> $converter0 =
      const EnumTextConverter<PropertyType>(PropertyType.values);
}

abstract class _$SprightlyDatabase extends GeneratedDatabase {
  _$SprightlyDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  late final $MembersTable members = $MembersTable(this);
  late final $CustomPropertiesTable customProperties =
      $CustomPropertiesTable(this);
  late final SprightlyDao sprightlyDao =
      SprightlyDao(this as SprightlyDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [members, customProperties];
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String name;
  final String value;
  final PropertyType? type;
  final DateTime createdOn;
  final DateTime? updatedOn;
  AppSetting(
      {required this.name,
      required this.value,
      this.type,
      required this.createdOn,
      this.updatedOn});
  factory AppSetting.fromData(Map<String, dynamic> data, {String? prefix}) {
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
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<String>(json['value']),
      type: serializer.fromJson<PropertyType?>(json['type']),
      createdOn: serializer.fromJson<DateTime>(json['createdOn']),
      updatedOn: serializer.fromJson<DateTime?>(json['updatedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<String>(value),
      'type': serializer.toJson<PropertyType?>(type),
      'createdOn': serializer.toJson<DateTime>(createdOn),
      'updatedOn': serializer.toJson<DateTime?>(updatedOn),
    };
  }

  AppSetting copyWith(
          {String? name,
          String? value,
          PropertyType? type,
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
  int get hashCode => Object.hash(name, value, type, createdOn, updatedOn);
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
  final Value<PropertyType?> type;
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
    Expression<PropertyType?>? type,
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
      Value<PropertyType?>? type,
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
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String?> value = GeneratedColumn<String?>(
      'value', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<PropertyType, String?> type =
      GeneratedColumn<String?>('type', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<PropertyType>($AppSettingsTable.$converter0);
  final VerificationMeta _createdOnMeta = const VerificationMeta('createdOn');
  @override
  late final GeneratedColumn<DateTime?> createdOn = GeneratedColumn<DateTime?>(
      'createdOn', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (STRFTIME(\'%s\',\'now\'))',
      clientDefault: () => DateTime.now().toUtc());
  final VerificationMeta _updatedOnMeta = const VerificationMeta('updatedOn');
  @override
  late final GeneratedColumn<DateTime?> updatedOn = GeneratedColumn<DateTime?>(
      'updatedOn', aliasedName, true,
      type: const IntType(),
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
    return AppSetting.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(_db, alias);
  }

  static TypeConverter<PropertyType, String> $converter0 =
      const EnumTextConverter<PropertyType>(
          PropertyType.values, PropertyType.String);
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

mixin _$SprightlyDaoMixin on DatabaseAccessor<SprightlyDatabase> {
  $MembersTable get members => attachedDatabase.members;
  $CustomPropertiesTable get customProperties =>
      attachedDatabase.customProperties;
}
mixin _$SprightlySetupDaoMixin on DatabaseAccessor<SprightlySetupDatabase> {
  $AppSettingsTable get appSettings => attachedDatabase.appSettings;
}
