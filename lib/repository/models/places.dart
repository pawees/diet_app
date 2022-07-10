import 'package:game_app_training/repository/models/diets.dart';

class Places {
  int id;
  String name;
  bool isFilled = false;
  List<Diets>? diets;

  Places({required this.id, required this.name, this.diets});

  static Places empty = Places(id: 0, name: 'unknow');

  isFilledMenu() {
    List<Diets> res = [];
    for (final el in diets!) {
      if (el.count != 0) {
        res.add(el);
      }
    }
    return res;
  }
  // List<Diets> isFilledMenu(){
  //   List<Diets> res = [];
  //   for (final el in diets!){

  //   if (el.count != 0 ){
  //     res.add(el);
  //   }
  //   return res;
  // }
  //constructor that convert json to object instance
  factory Places.fromJson(Map<String, dynamic> json) {
    return Places(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  //a method that convert object to json
  Map<String, dynamic> toJson() => {
        'uid_1c': id,
        'name': name,
      };
}
