import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Diets extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  int count;


  Diets(this.name, this.count);

  @override
  String toString() => 'Name: $name, count: $count';
}