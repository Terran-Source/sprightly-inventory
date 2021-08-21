// GENERATED CODE - DO NOT MODIFY BY HAND

part of sprightly.config;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) {
  return AppConfig(
    debug: json['debug'] as bool,
    recreateDatabase: json['recreateDatabase'] as bool,
  );
}

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
      'debug': instance.debug,
      'recreateDatabase': instance.recreateDatabase,
    };
