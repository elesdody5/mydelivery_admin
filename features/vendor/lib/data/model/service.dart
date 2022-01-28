class Service {
  String? id;
  String? photo;
  String? name;

  Service({this.id, this.photo, this.name});

  factory Service.fromJson(Map<String, dynamic> json) =>
      Service(id: json['_id'], photo: json['photo'], name: json['name']);
}
