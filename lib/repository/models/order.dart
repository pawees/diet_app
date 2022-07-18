import 'package:game_app_training/repository/models/agency.dart';
import 'package:game_app_training/repository/models/date.dart';
import 'package:game_app_training/repository/models/places.dart';
import 'package:jiffy/jiffy.dart';

class Order {
  String id;
  Agency? agency;
  String? agency_uid;
  String? user_uid;
  Date? date;
  List<Places>? places;

  Order(
      {required this.id,
      this.places,
      this.agency_uid,
      this.date,
      this.user_uid,
      this.agency});

  //constructor that convert json to object instance
  factory Order.fromJson(Map<String, dynamic> json) {
    String date = json['order_date'].split('T')[0];
    
    return Order(
      id: json['order_number'] as String,
      date: Date(date_for_request: Jiffy(date).format('yyyy-MM-dd'),
                  dd_mm_yyyy: Jiffy(date).format('dd.MM.yyyy'),
                  day_of_week: Jiffy(date).EEEE ),
      user_uid: json['0-0-0-0'],
      agency_uid: json['customer']['uid_1c'],
      agency: Agency(address:'адресс', name: json['customer']['name_1c'], uid_1c:json['customer']['uid_1c'] ),            
      places: (json['customer_division'] as List<dynamic>)
      .map(( e) => Places.fromJson(e as Map<String,dynamic>))
      .toList()
    );
  }

  //a method that convert object to json
  Map<String, dynamic> toJson(user, agency, place, diet, date, count) => {
        //get parameters

        "user": "2980d87d-d51e-11ec-aab9-0050560f0271",
        "customer": "fd6b328e-ba93-11ea-aab0-005056aeb06b",
        "customer_division": "2bbc0ebd-d7ab-11ea-aab2-005056aeb06b",
        "peoples_category": "3ba6eff9-ba94-11ea-aab0-005056aeb06b",
        "diet": "3ba6effd-ba94-11ea-aab0-005056aeb06b",
        "date_execution": "2022-06-03",
        "count": count //100
      };
}
