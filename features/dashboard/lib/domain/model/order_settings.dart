class OrderSettings {
  int? firstRidePrice;
  int? otherRidePrice;
  bool? enableOrders;

  OrderSettings({this.firstRidePrice, this.otherRidePrice, this.enableOrders});

  factory OrderSettings.fromJson(Map<String, dynamic> json) => OrderSettings(
      firstRidePrice: json['firstRidePrice'],
      otherRidePrice: json['otherRidePrice'],
      enableOrders: json['enableOrders']);

  Map<String, dynamic> toJson() => {
        "firstRidePrice": firstRidePrice,
        "otherRidePrice": otherRidePrice,
        "enableOrders": enableOrders
      };
}
