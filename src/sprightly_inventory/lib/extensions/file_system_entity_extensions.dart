import 'dart:io';
import 'package:path/path.dart' as p;

extension FileSystemExtension on FileSystemEntity {
  String get name => p.basename(this.path);
  String get basePath => p.dirname(this.path);
}
