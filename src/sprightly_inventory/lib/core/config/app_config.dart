library sprightly.config;

import 'dart:convert';

import 'package:dart_marganam/extensions.dart';
import 'package:dart_marganam/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as p;
import 'package:sprightly_inventory/core/config/enums.dart';

part 'app_config.g.dart';

@JsonSerializable()
class AppConfig extends Equatable {
  const AppConfig({this.debug = false, this.recreateDatabase = false});

  final bool debug;
  final bool recreateDatabase;

  @override
  List<Object> get props => [debug, recreateDatabase];

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);

  Map<String, dynamic> get toJson => _$AppConfigToJson(this);

  static String get _configBaseDirectory => 'assets/config';
  static String get _configBaseFile => 'config.json';

  static Future<Map<String, dynamic>?> _jsonMap(String configFileName) async {
    try {
      return json.decode(await getAssetText(configFileName,
          assetDirectory: _configBaseDirectory)) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  static Future<AppConfig> of(
      {Environment environment = Environment.prod}) async {
    var json = await _jsonMap(_configBaseFile);
    final envConfigFile = "${[
      p.basenameWithoutExtension(_configBaseFile),
      environment.toEnumString().toLowerCase()
    ].join('.')}"
        "${p.extension(_configBaseFile)}";
    final jsonEnv = await _jsonMap(envConfigFile);
    json ??= (json?.extend(jsonEnv!) as Map<String, dynamic>?) ?? jsonEnv;
    if (null != json) return AppConfig.fromJson(json);
    return const AppConfig();
  }
}
