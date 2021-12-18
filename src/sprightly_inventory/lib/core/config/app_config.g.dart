// GENERATED CODE - DO NOT MODIFY BY HAND

part of sprightly.config;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
      dbConfig: json['dbConfig'] == null
          ? null
          : DbConfig.fromJson(json['dbConfig'] as Map<String, dynamic>),
      debug: json['debug'] as bool?,
      recreateDatabase: json['recreateDatabase'] as bool?,
    );

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dbConfig', instance.dbConfig?.toJson());
  val['debug'] = instance.debug;
  val['recreateDatabase'] = instance.recreateDatabase;
  return val;
}

DbConfig _$DbConfigFromJson(Map<String, dynamic> json) => DbConfig(
      appDataDbFile: json['appDataDbFile'] as String?,
      setupDataDbFile: json['setupDataDbFile'] as String?,
      sqlSourceAsset: json['sqlSourceAsset'] as String?,
      sqlSourceWeb: json['sqlSourceWeb'] as String?,
      hashedIdMinLength: json['hashedIdMinLength'] as int?,
      uniqueRetry: json['uniqueRetry'] as int?,
    );

Map<String, dynamic> _$DbConfigToJson(DbConfig instance) => <String, dynamic>{
      'appDataDbFile': instance.appDataDbFile,
      'setupDataDbFile': instance.setupDataDbFile,
      'sqlSourceAsset': instance.sqlSourceAsset,
      'sqlSourceWeb': instance.sqlSourceWeb,
      'hashedIdMinLength': instance.hashedIdMinLength,
      'uniqueRetry': instance.uniqueRetry,
    };
