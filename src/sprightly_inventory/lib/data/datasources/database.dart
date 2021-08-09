library sprightly.moor_database;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'package:sprightly_inventory/data/constants/enums.dart';
import 'package:sprightly_inventory/data/dao.dart';
import 'package:sprightly_inventory/extensions/moor/enum_type_converter.dart';
import 'package:sprightly_inventory/extensions/enum_extensions.dart';
import 'package:sprightly_inventory/utils/file_provider.dart';
import 'package:sprightly_inventory/utils/happy_hash.dart';
import 'package:sprightly_inventory/utils/ready_or_not.dart';

part 'database.g.dart';

String get appDataDbFile => 'sprightly_inventory_db.lite';
String get setupDataDbFile => 'sprightly_setup.lite';
String get sqlAssetDirectory => 'assets/queries_min';
int get hashedIdMinLength => 16;
int get uniqueRetry => 5;
