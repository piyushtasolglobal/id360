import 'dart:convert';

City countryFromJson(String str) {
  final jsonData = json.decode(str);
  return City.fromMap(jsonData);
}

String clientToJson(City data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class City {
  int id;
  String name;
  int state_id;

  City({
    this.id,
    this.name,
    this.state_id,
  });

  factory City.fromMap(Map<String, dynamic> json) => new City(
    id: json["id"],
    name: json["name"],
    state_id: json["country_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "state_id": state_id,
  };
}