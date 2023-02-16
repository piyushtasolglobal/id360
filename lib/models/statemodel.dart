import 'dart:convert';

State countryFromJson(String str) {
  final jsonData = json.decode(str);
  return State.fromMap(jsonData);
}

String clientToJson(State data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class State {
  int id;
  String name;
  int country_id;

  State({
    this.id,
    this.name,
    this.country_id,
  });

  factory State.fromMap(Map<String, dynamic> json) => new State(
    id: json["id"],
    name: json["name"],
    country_id: json["country_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "country_id": country_id,
  };
}