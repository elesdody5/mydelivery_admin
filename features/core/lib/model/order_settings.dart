class OrderSettings {
  int? firstRidePrice;
  int? otherRidePrice;
  bool? enableOrders;
  String? password;
  double? profitPercent;

  OrderSettings(
      {this.firstRidePrice,
      this.otherRidePrice,
      this.enableOrders,
      this.password,
      this.profitPercent});

  factory OrderSettings.fromJson(Map<String, dynamic> json) => OrderSettings(
      firstRidePrice: json['firstRidePrice'],
      otherRidePrice: json['otherRidePrice'],
      enableOrders: json['enableOrders'],
      password: json["password"],
      profitPercent: json['profitPercent']);

  Map<String, dynamic> toJson() => {
        "firstRidePrice": firstRidePrice,
        "otherRidePrice": otherRidePrice,
        "enableOrders": enableOrders,
        "profitPercent": profitPercent
      };
}
