enum UserType {
  user,
  vendor,
  delivery,
}

extension EnumToString on UserType {
  String enmToString() {
    switch (this) {
      case UserType.user:
        return "user";
      case UserType.delivery:
        return "delivery";
      case UserType.vendor:
        return "vendor";
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
    default:
      return null;
  }
}
