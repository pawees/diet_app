import 'package:json_annotation/json_annotation.dart';


@JsonSerializable(fieldRename: FieldRename.snake)
class Places{
  const Places({
    this.id,
    this.name,
  });

  final String? id;
  final String? name;

  static const empty = Places(
    id: '',
    name: '',);
 

  // factory Places.fromJson(Map<String, dynamic> json) {
  //       return Places(id: json['id'] as String,
  //               access: json['access'] as String,
  //               user_id: json['user_id'] as String,);
  // };
}
