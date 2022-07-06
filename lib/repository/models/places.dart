import 'package:game_app_training/repository/models/diets.dart';

class Places {
  String id;
  String name;
  List<Diets>? diets;

  Places({required this.id, required this.name,this.diets});

 static Places empty = Places(
    id: '0',
    name: 'unknow');
  
  //constructor that convert json to object instance
  factory Places.fromJson(Map<String, dynamic> json) {
    return Places(id: json['id'] as String,
                name: json['name'] as String,
                );
    }

  //a method that convert object to json
  Map<String, dynamic> toJson() => {
    'uid_1c': id,
    'name': name,
  };
}