import 'package:dart_marganam/db.dart';

void updateDbEnumTypes() {
  enumTypes[MemberIdType] = MemberIdType.values;
  enumTypes[GroupType] = GroupType.values;
  enumTypes[AccountType] = AccountType.values;
  enumTypes[CategoryType] = CategoryType.values;
  enumTypes[TransactionTag] = TransactionTag.values;
  enumTypes[GroupActivityType] = GroupActivityType.values;
  enumTypes[FontType] = FontType.values;
  enumTypes[FontStyle] = FontStyle.values;
  enumTypes[ThemeMode] = ThemeMode.values;
  enumTypes[PropertyType] = PropertyType.values;
  enumTypes[ResourceFrom] = ResourceFrom.values;
  enumTypes[Environment] = Environment.values;
}

/// Database enums
///
/// any changes here should be replicated manually in the
/// above [enumTypes] List
/// as moor can't handle dynamic string in `customConstraint`
///
/// otherwise, it'd be like
/// ```dart
/// customConstraint("${MemberIdType.values.getConstraints('idType')} NOT NULL")
/// ```
/// instead of
/// ```dart
/// customConstraint("CHECK (idType IN ('Phone', 'Email', 'NickName', 'Group')) NOT NULL")
/// ```
/// for `Members`.`idType`

enum MemberIdType { Phone, Email, NickName, Custom }
enum GroupType { Personal, Budget, Shared }
enum AccountType { Group, Cash, Credit, Bank, Investment }
enum CategoryType { Expense, Liability, Income, Investment, Misc }
enum TransactionTag { Special, Star }

// package:sprightly_inventory/models
enum GroupActivityType {
  /// GroupActivity operations like: created/updated(like name etc.)/deleted
  GroupActivity,

  /// GroupAccountMember operations like: created/updated(like name etc.)/deleted
  Account,

  /// GroupOnlyMember operations like: created/updated(like name etc.)/deleted
  Member,

  /// GroupTransaction operations like: created/updated(like name etc.)/deleted
  Transaction,

  /// GroupSettlement operations like: created/updated(like name etc.)/deleted
  Settlement,
}

// Setup DB
enum FontType { Regular, Mono }
enum FontStyle { Regular, Italic, Bold, BoldItalic }
enum ThemeMode { Bright, Dark }
enum PropertyType { String, Number, Bool, DateTime, Blob, List }

//
enum ResourceFrom { Asset, Web }

enum Environment { dev, stage, prod }
