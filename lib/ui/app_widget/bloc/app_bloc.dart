import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_app_training/repository/app_repository.dart';
import 'package:game_app_training/repository/models/diets.dart';
import 'package:game_app_training/repository/models/order.dart';
import 'package:game_app_training/repository/models/places.dart';
import 'package:game_app_training/repository/session.dart';
import 'package:game_app_training/ui/app_widget/orderCreateWidget.dart';

import 'package:jiffy/jiffy.dart';

part 'app_event.dart';
part 'app_state.dart';
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required this.appRepository,
  }) : super(AppState()) {
    _initial();
  }
  
  final GameRepository appRepository;
  final _token = SessionState();


  void _initial() {
    on<AppEvent>(_getOrders);
    on<AppInitialEvent>(_getOrdersNew);
    on<TapProfileNavEvent>(_getProfile);
    on<TapCreateOrderEvent>(_getCreate);
    on<TapNextDateEvent>(_nextDate);
    on<GetMenuEvent>(_getMenu);
    on<ChangeCountEvent>(_changeCount);
    on<NextPlaceEvent>(_nextPlace);
    on<FormOrderEvent>(_formOrder);

  }
  Future<void> _getCreate(TapCreateOrderEvent e, Emitter emit) async {
  var access_token = await _token.token_data.getAccessToken();
    emit(state.copyWith(status: AppStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
  // final places = await appRepository.getPlaces(access_token!);

  // this is plug,like data were received 
   final List<String> data = ["Хирургия(Взрослые)","Наркология(Взрослые)","Детское(Дети,Роженицы)","Травматология(Взрослые)",
  "Хирургия(Взрослые)","Наркология(Взрослые)","Детское(Дети,Роженицы)","Травматология(Взрослые)",
  "Хирургия(Взрослые)","Наркология(Взрослые)","Детское(Дети,Роженицы)","Травматология(Взрослые)",];
  
  final Map<String,String> data2 = {'id':'1','name':"Хирургия(Взрослые)"};
  final Map<String,String> data3 = {'id':'2','name':"Терапия(Взрослые)"};
  final Map<String,String> data4 = {'id':'3','name':"Наркология(Взрослые)"};


  //
  final places = [Places.fromJson(data2),Places.fromJson(data3),Places.fromJson(data4)];


  emit(state.copyWith(status: AppStatus.create,
                       places: places)); // create data field


  }
  Future<void> _getOrders(AppEvent e, Emitter emit) async {
    // do some check user for authorization
    // emit(AuthorizeState(msg: "login_sucess"));
  }

  Future<void> _getOrdersNew(AppInitialEvent e, Emitter emit) async {
  // do some check user for authorization
  // emit(AuthorizeState(msg: "login_sucess"));
  emit(state.copyWith(status: AppStatus.loading, date: Jiffy().format()));
  await Future.delayed(const Duration(seconds: 2));
  emit(state.copyWith(status: AppStatus.order));
}

  Future<void> _getProfile(TapProfileNavEvent e, Emitter emit) async {

  emit(state.copyWith(status: AppStatus.loading));
  await Future.delayed(const Duration(seconds: 1));
  emit(state.copyWith(status: AppStatus.profile));

}
Future<void> _nextDate(TapNextDateEvent e, Emitter emit) async {
  var prev=state.date;
  print(prev);
  emit(state.copyWith(status: AppStatus.create,
                       date: Jiffy().add(duration: Duration(days: e.count)).EEEE));

}
Future<void> _getMenu(GetMenuEvent e, Emitter emit) async {
    emit(state.copyWith(status: AppStatus.selected, selected_id: e.id));
}

Future<void> _changeCount(ChangeCountEvent e, Emitter emit) async {
  emit(state.copyWith(status: AppStatus.create,));
  emit(state.copyWith(status: AppStatus.selected));
}

Future<void> _nextPlace(NextPlaceEvent e, Emitter emit) async {
  emit(state.copyWith(status: AppStatus.next_page, is_filled: true));
  emit(state.copyWith(status: AppStatus.selected, selected_id: e.id));
  //isChanged == true,this need for icon in list
}
Future<void> _formOrder(FormOrderEvent e, Emitter emit) async {
    //save to db;
    //
    emit(state.copyWith(status: AppStatus.pre_req_order));


}

}
