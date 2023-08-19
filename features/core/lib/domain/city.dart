
class City {
  String? id;
  String? name;
  num? price;

  City({this.id, this.name, this.price});

  factory City.fromJson(Map<String, dynamic> data, String id) =>
      City(id: id, name: data["name"], price: data["price"]);

  Map<String, dynamic> toJson() => {"name": name, "price": price};
}
