
class Places {
  final String id;
  final String name;

  const Places({required this.id, required this.name});

 static const Places empty = Places(
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