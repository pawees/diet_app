import 'package:game_app_training/repository/models/diets_hive.dart';
import 'package:hive/hive.dart';


@HiveType(typeId: 1)
class PlacesHive extends HiveObject {
  // removed HiveFieldsId: 2

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(3)
  HiveList<Diets>? diets;

  PlacesHive(this.id, this.name, this.diets);

  @override
  String toString() => 'Name: $name';
}