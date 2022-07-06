import 'package:game_app_training/repository/models/places.dart';

class Order {
  String id;
  List<Places>? places;

  Order({required this.id,  this.places});

  //constructor that convert json to object instance
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(id: json['id'] as String,
                places: json['places'] as List<Places>,
                );
    }

  //a method that convert object to json
  Map<String, dynamic> toJson() => {
    'id': id,
    'places': places,
  };
}