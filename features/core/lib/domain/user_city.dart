class UserCity {
  String? id;
  String? name;

  UserCity({this.id, this.name});

  factory UserCity.fromJson(Map<String, dynamic> data) =>
      UserCity(id: data["_id"], name: data["name"],);

}