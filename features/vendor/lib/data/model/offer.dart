class Offer {
  Offer({
    this.id,
    this.photo,
    this.description,
    this.shop,
  });

  String? id;
  String? photo;
  String? description;
  String? shop;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["_id"],
        photo: json["photo"],
        description: json["description"],
        shop: json["shop"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "photo": photo,
        "description": description,
        "shop": shop,
      };
}
