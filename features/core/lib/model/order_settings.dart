class OrderSettings {
  int? firstRidePrice;
  int? otherRidePrice;
  bool? enableOrders;
  String? password;

  OrderSettings(
      {this.firstRidePrice,
      this.otherRidePrice,
      this.enableOrders,
      this.password});

  factory OrderSettings.fromJson(Map<String, dynamic> json) => OrderSettings(
      firstRidePrice: json['firstRidePrice'],
      otherRidePrice: json['otherRidePrice'],
      enableOrders: json['enableOrders'],
      password: json["password"]);

  Map<String, dynamic> toJson() => {
        "firstRidePrice": firstRidePrice,
        "otherRidePrice": otherRidePrice,
        "enableOrders": enableOrders
      };
}
