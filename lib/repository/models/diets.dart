
class Diets {
  final String name;
  int count;


  Diets({required this.count, required this.name});

//  static const Diets empty = Diets(
//     count: 0,
//     name: 'unknow');
  
  //constructor that convert json to object instance
  factory Diets.fromJson(Map<String, dynamic> json) {
    return Diets(count: json['count'] as int,
                name: json['name'] as String,
                );
    }

  //a method that convert object to json
  Map<String, dynamic> toJson() => {
    'name': name,
    'count': count,
  };
}