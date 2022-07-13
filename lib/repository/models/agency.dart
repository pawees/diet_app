import 'package:game_app_training/repository/models/places.dart';

class Agency {
  String? name;
  String? address;
  String? uid_1c;

  Agency({this.name, this.address, this.uid_1c});

  //constructor that convert json to object instance
  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      uid_1c: json['uid_1c'] as String,
      name: json['name_1c'] as String,
      address: json['location'] as String,
    );
  }

  //a method that convert object to json
  Map<String, dynamic> toJson() =>
      {'uid_1c': uid_1c, 'name_1c': name, 'location': address};
}
