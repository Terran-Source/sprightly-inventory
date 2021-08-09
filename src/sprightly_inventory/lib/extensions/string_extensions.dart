extension Trimmer on String {
  String get escapedTrim => RegExp.escape(this.trim());

  String trimming(String trimmer) {
    final pattern = RegExp(
        '^[${trimmer.escapedTrim}]+(.*(?<![${trimmer.escapedTrim}]+))[${trimmer.escapedTrim}]+',
        caseSensitive: true,
        multiLine: false,
        dotAll: true);
    return this
        .trim()
        .replaceAllMapped(pattern, (match) => '${match.group(1)}')
        .trim();
  }

  String trimmed(List<String> trimmer) =>
      trimmer.fold(this, (str, trm) => str.trimming(trm));

  List<String> toList() =>
      this.runes.map((e) => new String.fromCharCode(e)).toList();

  Set<String> toSet() => Set.from(this.toList());
}

final _allowedCharacters =
    new RegExp(r'[\w_]+', multiLine: false, unicode: true, dotAll: true);

extension CleanString on String {
  String? escapeMessy([String escapeWith = '_']) => _allowedCharacters
      .allMatches(this.trim())
      .map((match) => match.group(0))
      .join(escapeWith);
}
