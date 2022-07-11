import 'package:game_app_training/repository/models/places.dart';

class Agency {
  String? id;
  String? name;
  String? address;

  Agency({this.id, this.name, this.address});

  //constructor that convert json to object instance
  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(id: json['id'] as String,
                name: json['name'] as String,
                address: json['address'] as String,
                );
    }

  //a method that convert object to json
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address':address
  };
}