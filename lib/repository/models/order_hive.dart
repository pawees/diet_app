import 'package:game_app_training/repository/models/places.dart';
import 'package:hive/hive.dart';
import 'package:game_app_training/repository/models/places_hive.dart';



@HiveType(typeId: 2)
class Order extends HiveObject {

  @HiveField(0)
  String id;

  @HiveField(1)
  String date;
  
  @HiveField(2)
  String agency;

  @HiveField(3)
  HiveList<PlacesHive>? places;

  Order(this.id, this.date, this.agency,this.places);

  @override
  String toString() => 'id: $id';
}