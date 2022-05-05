enum AccountType { owner, user }

extension AccountTypeExtension on AccountType {
  String get rawValue {
    switch (this) {
      case AccountType.owner:
        return 'owner';
      case AccountType.user:
        return 'user';
      default:
        return 'unknown';
    }
  }
}
