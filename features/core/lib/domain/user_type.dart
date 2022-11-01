enum UserType { user, vendor, delivery, admin }

extension EnumToString on UserType {
  String enmToString() {
    switch (this) {
      case UserType.user:
        return "user";
      case UserType.delivery:
        return "delivery";
      case UserType.vendor:
        return "vendor";
      case UserType.admin:
        return "admin";
      default:
        return "user";
    }
  }
}

UserType? stringToEnum(String? type) {
  switch (type) {
    case "vendor":
      return UserType.vendor;
    case "user":
      return UserType.user;
    case "delivery":
      return UserType.delivery;
    case "admin":
      return UserType.admin;
    default:
      return null;
  }
}
