import 'package:json_annotation/json_annotation.dart';


@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  const User({
    this.refresh,
    required this.access,

  });

  final String? refresh;
  final String access;




  factory User.fromJson(Map<String, dynamic> json) {
    return User(refresh: json['refresh'] as String,
                access: json['access'] as String,
                );
    }
}
