import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_app_training/repository/app_repository.dart';
import 'package:game_app_training/repository/session.dart';

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
  //

  emit(state.copyWith(status: AppStatus.create,
                       places: data)); // create data field


  }
  Future<void> _getOrders(AppEvent e, Emitter emit) async {
    // do some check user for authorization
    // emit(AuthorizeState(msg: "login_sucess"));
  }

  Future<void> _getOrdersNew(AppInitialEvent e, Emitter emit) async {
  // do some check user for authorization
  // emit(AuthorizeState(msg: "login_sucess"));
  emit(state.copyWith(status: AppStatus.loading, date: Jiffy().format()));
  await Future.delayed(const Duration(seconds: 1));
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
    emit(state.copyWith(status: AppStatus.selected));
}



}
