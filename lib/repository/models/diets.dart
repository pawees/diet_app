
class Diets {
  final String name;
  int count;


  Diets({required this.count, required this.name});

//  static const Diets empty = Diets(
//     count: 0,
//     name: 'unknow');


static List<Diets> fetchAll() {
  return  [
  Diets(name: 'ОВД', count: 0),
  Diets(name:'Зонд',count:0),
  Diets(name:'ОВД2',count:0),
  Diets(name:'ЩД',count:0),
  Diets(name:'НКД',count:0),
  Diets(name:'ОВДм',count:0),
  Diets(name:'ОВД',count:0),
  Diets(name:'ЩД1',count:0),
  Diets(name:'ОВдр',count:0),
  Diets(name:'ЩДб/м',count:0),
  Diets(name:'Х1',count:0),
  Diets(name:'ВБД1',count:0),
  ];
}
  
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