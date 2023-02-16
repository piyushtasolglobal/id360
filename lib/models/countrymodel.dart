import 'dart:convert';

Country countryFromJson(String str) {
  final jsonData = json.decode(str);
  return Country.fromMap(jsonData);
}

String clientToJson(Country data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Country {
  int id;
  String shortname;
  String name;
  int phonecode;

  Country({
    this.id,
    this.shortname,
    this.name,
    this.phonecode,
  });

  factory Country.fromMap(Map<String, dynamic> json) => new Country(
    id: json["id"],
    shortname: json["shortname"],
    name: json["name"],
    phonecode: json["phonecode"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "first_name": shortname,
    "last_name": name,
    "blocked": phonecode,
  };
}