class Diets {
  int? pk;
  final String name;
  int count;
  String? uid;

  Diets({required this.count, required this.name, this.uid,this.pk});

//  static const Diets empty = Diets(
//     count: 0,
//     name: 'unknow');

  factory Diets.fromJson(Map<String, dynamic> json) {
    try{
      return Diets(
      count: json['count'] as int,
      name: json['diet']['name_1c'] as String,
      uid: json['diet']['uid_1c'] as String,
      pk: json['pk'] as int,
    );
    }catch(e){
      return Diets(
      count: 0,  
      name: json['name_1c'] as String,
      uid: json['uid_1c'] as String,
    );
    }
    
  }


  Map<String, dynamic> toJson() => {
        'name': name,
        'count': count,
      };
}
