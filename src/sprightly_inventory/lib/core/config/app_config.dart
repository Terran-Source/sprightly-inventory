library sprightly.config;

import 'dart:convert';
import 'dart:io';

import 'package:dart_marganam/extensions/enum.dart';
import 'package:dart_marganam/utils/file_provider.dart';
import 'package:dart_marganam/utils/formatted_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:extend/extend.dart';
import 'package:interpolation/interpolation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as p;
import 'package:sprightly_inventory/core/config/enums.dart';

part 'app_config.g.dart';

@JsonSerializable(explicitToJson: true)
class AppConfig extends Equatable {
  const AppConfig({
    this.dbConfig,
    this.debug,
    this.recreateDatabase,
  });

  @JsonKey(includeIfNull: false)
  final DbConfig? dbConfig;
  final bool? debug;
  final bool? recreateDatabase;

  @override
  List<Object?> get props => [
        dbConfig,
        debug,
        recreateDatabase,
      ];

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);
  Map<String, dynamic> get toJson => _$AppConfigToJson(this);

  static String get _configBaseDirectory => 'assets/config';
  static String get _configBaseFile => 'config.json';

  static Future<Map<String, dynamic>?> _jsonMap(String configFileName) async {
    try {
      return json.decode(
        await getAssetText(
          configFileName,
          assetDirectory: _configBaseDirectory,
        ),
      ) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  static Future<AppConfig> of({
    Environment environment = Environment.prod,
  }) async {
    final arguments = <String>[];

    var json = await _jsonMap(_configBaseFile);
    if (null == json) arguments.add("configFileName: $_configBaseFile");
    final envConfigFile = "${[
      p.basenameWithoutExtension(_configBaseFile),
      environment.toEnumString().toLowerCase()
    ].join('.')}"
        "${p.extension(_configBaseFile)}";
    final jsonEnv = await _jsonMap(envConfigFile);
    json ??= (json?.extend(jsonEnv!) as Map<String, dynamic>?) ?? jsonEnv;
    if (null != json) {
      final _interpolation = Interpolation();
      json.extend({'environment': environment});
      return AppConfig.fromJson(
        _interpolation.resolve(json) as Map<String, dynamic>,
      );
    }
    arguments.add("envConfigFile: $envConfigFile");
    throw appConfigException(arguments);
  }

  static FormattedException appConfigException(
    List<String> arguments, [
    String message = "Failed to initiate AppConfig",
    int errorCode = 0,
  ]) =>
      FormattedException(
        ProcessException('AppConfig', arguments, message, errorCode),
      );
}

@JsonSerializable()
class DbConfig extends Equatable {
  const DbConfig({
    this.appDataDbFile,
    this.setupDataDbFile,
    this.sqlSourceAsset,
    this.sqlSourceWeb,
    this.hashedIdMinLength,
    this.uniqueRetry,
  });

  final String? appDataDbFile;
  final String? setupDataDbFile;
  final String? sqlSourceAsset;
  final String? sqlSourceWeb;
  final int? hashedIdMinLength;
  final int? uniqueRetry;

  @override
  List<Object?> get props => [
        appDataDbFile,
        setupDataDbFile,
        sqlSourceAsset,
        sqlSourceWeb,
        hashedIdMinLength,
        uniqueRetry,
      ];

  factory DbConfig.fromJson(Map<String, dynamic> json) =>
      _$DbConfigFromJson(json);
  Map<String, dynamic> get toJson => _$DbConfigToJson(this);
}
