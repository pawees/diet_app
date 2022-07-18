import 'package:game_app_training/repository/models/diets.dart';

class Places {
  String name;
  String? uid_1c;
  bool isFilled = false;
  List<Diets>? diets;

  Places({required this.name, this.diets, this.uid_1c});

  static Places empty = Places(name: 'unknow');

  isFilledMenu() {
    List<Diets> res = [];
    for (final el in diets!) {
      if (el.count != 0) {
        res.add(el);
      }
    }
    return res;
  }

  bool isFilledMenuSum() {
    int count = 0;
    for (final el in diets!) {
      count += el.count;
    }
    if (count == 0) {
      return true;
    } else {
      return false;
    }
  }

  //constructor that convert json to object instance
  factory Places.fromJson(Map<String, dynamic> json) {
    if (json.length == 2){
      return Places(
      uid_1c: json['uid_1c'] as String,
      name: json['name_1c'] as String,);

    }else{}
    return Places(
      uid_1c: json['uid_1c'] as String,
      name: json['name_1c'] as String,
      diets: (json['diets'] as List<dynamic>)
      .map((e) => Diets.fromJson(e as Map<String,dynamic>))
      .toList()
    );
  }

  //a method that convert object to json
  Map<String, dynamic> toJson() => {
        'uid_1c': uid_1c,
        'name': name,
      };
}
