class Address {
  String? fullAddress;
  String? startDestination;
  String? endDestination;

  Address({this.fullAddress, this.startDestination, this.endDestination});

  factory Address.fromJson(String? address) {
    String? startDestination;
    String? endDestination;
    String? fullAddress;
    if (address?.contains("/") == true) {
      List<String>? addresses = address?.split("/");
      startDestination = addresses?[0];
      endDestination = addresses?[1];
      if (endDestination == "null") endDestination = null;
    } else {
      fullAddress = address;
    }
    return Address(
        fullAddress: fullAddress,
        startDestination: startDestination,
        endDestination: endDestination);
  }

  String toJson() => "${startDestination ?? ""}/${endDestination ?? ""} ";
}

extension SearchAddress on Address {
  bool? contains(String address) {
    return fullAddress != null
        ? fullAddress?.contains(address)
        : startDestination?.contains(address);
  }
}
