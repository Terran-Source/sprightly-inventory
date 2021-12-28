class DbConfig {
  factory DbConfig() => universal;
  static DbConfig universal = DbConfig._();
  DbConfig._();

  String sqlSourceAsset = 'assets/queries_min';
  String? sqlSourceWeb;
  int hashedIdMinLength = 16;
  int uniqueRetry = 5;

  void update({
    String? sqlSourceAsset,
    String? sqlSourceWeb,
    int? hashedIdMinLength,
    int? uniqueRetry,
  }) {
    this.sqlSourceAsset = sqlSourceAsset ?? this.sqlSourceAsset;
    this.sqlSourceWeb = sqlSourceWeb ?? this.sqlSourceWeb;
    this.hashedIdMinLength = hashedIdMinLength ?? this.hashedIdMinLength;
    this.uniqueRetry = uniqueRetry ?? this.uniqueRetry;
  }
}

final dbConfig = DbConfig();
