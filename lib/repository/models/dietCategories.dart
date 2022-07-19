import 'package:game_app_training/repository/models/places.dart';

class CategoryDiet {
  final String? name;
  final String? uid_1c;

  const CategoryDiet({this.name, this.uid_1c});

  static const empty = CategoryDiet(
    name: '',

    uid_1c: '',
  );

  //constructor that convert json to object instance
  factory CategoryDiet.fromJson(Map<String, dynamic> json) {
    return CategoryDiet(
      uid_1c: json['uid_1c'] as String,
      name: json['name_1c'] as String,
    );
  }

  //a method that convert object to json
  Map<String, dynamic> toJson() =>
      {'uid_1c': uid_1c, 'name_1c': name,};
}
