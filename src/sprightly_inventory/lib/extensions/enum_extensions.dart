import 'dart:math';

extension Enums<T> on List<T> {
  static String toEnumString<T>(T value, [bool withQuote = false]) {
    final val = value.toString().split(".").last;
    return withQuote ? "'$val'" : val;
  }

  T? find(String val) {
    try {
      return this.firstWhere((ab) => ab.toString() == '${ab.runtimeType}.$val');
    } catch (_) {
      return null;
    }
  }

  Iterable<String> toStrings([bool withQuote = false]) =>
      this.map((item) => toEnumString(item, withQuote));

  T get random => this[Random().nextInt(this.length)];

  String randomString([bool withQuote = false]) =>
      toEnumString(this.random, withQuote);

  String getConstraints(String columnName) =>
      'CHECK ($columnName IN (${this.toStrings(true).join(',')}))';
}

extension EnumExt<T> on T {
  String toEnumString([bool withQuote = false]) =>
      Enums.toEnumString(this, withQuote);
}
