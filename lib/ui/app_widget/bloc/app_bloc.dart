import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_app_training/repository/app_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required this.appRepository,
  }) : super(AppState()) {
    _initial();
  }
  
  final GameRepository appRepository;

  void _initial() {
    on<AppEvent>(_getOrders);
    on<AppInitialEvent>(_getOrdersNew);
    on<TapProfileNavEvent>(_getProfile);
    on<TapCreateOrderEvent>(_getCreate);
  }
  Future<void> _getCreate(TapCreateOrderEvent e, Emitter emit) async {
  // load data and send with state variable
  List data = ["Хирургия(Взрослые),Хирургия(Взрослые),Хирургия(Взрослые),Хирургия(Взрослые),Хирургия(Взрослые),Хирургия(Взрослые),"];
  emit(state.copyWith(status: AppStatus.create)); // create data field


  }
  Future<void> _getOrders(AppEvent e, Emitter emit) async {
    // do some check user for authorization
    // emit(AuthorizeState(msg: "login_sucess"));
  }

  Future<void> _getOrdersNew(AppInitialEvent e, Emitter emit) async {
  // do some check user for authorization
  // emit(AuthorizeState(msg: "login_sucess"));
  emit(state.copyWith(status: AppStatus.loading));
  await Future.delayed(const Duration(seconds: 1));
  emit(state.copyWith(status: AppStatus.order));
}

  Future<void> _getProfile(TapProfileNavEvent e, Emitter emit) async {

  emit(state.copyWith(status: AppStatus.loading));
  await Future.delayed(const Duration(seconds: 1));
  emit(state.copyWith(status: AppStatus.profile));

}
}
