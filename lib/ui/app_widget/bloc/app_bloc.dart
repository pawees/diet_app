import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_app_training/repository/app_repository.dart';
import 'package:game_app_training/repository/models/agency.dart';
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
    on<HaveNewOrderEvent>(_haveNewOrder);
    on<PreviousScreenEvent>(_previousScreen);
  }

  Future<void> _getCreate(TapCreateOrderEvent e, Emitter emit) async {
    emit(state.copyWith(status: AppStatus.loading));

    var user_uid = await appRepository.getUserInfo();
    var agencies = await appRepository.getAgencies();

    //FIXME this opened modal window,
    //build from availeble agencies.

    //

    List<Places> listPlaces = [];
    Order order = Order(id: '000-00-0', places: listPlaces);

    final places = await appRepository.getPlaces(agencies[0].uid_1c);

    emit(state.copyWith(
        agency: agencies[0], //FIXME temp
        status: AppStatus.create,
        places: places,
        previous: e.prev_status,
        order: order,
        user_uid: user_uid)); // create data field
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
    var prev = state.date;
    print(prev);
    emit(state.copyWith(
        status: AppStatus.create,
        date: Jiffy().add(duration: Duration(days: e.count)).EEEE));
  }

  Future<void> _getMenu(GetMenuEvent e, Emitter emit) async {
    //FIXME
    emit(state.copyWith(status: AppStatus.loading));
    List<Diets> diets = await appRepository.getDiets();
    emit(state.copyWith(
        status: AppStatus.selected, selected_id: e.id, diets: diets));
  }

  Future<void> _changeCount(ChangeCountEvent e, Emitter emit) async {
    emit(state.copyWith(
      status: AppStatus.create,
    ));
    emit(state.copyWith(status: AppStatus.selected));
  }

  Future<void> _nextPlace(NextPlaceEvent e, Emitter emit) async {
//get list in event,check that list have count>0;is_filled == true then
    emit(state.copyWith(status: AppStatus.next_page, is_filled: true));
    emit(state.copyWith(status: AppStatus.selected, selected_id: e.id));
  }

  Future<void> _formOrder(FormOrderEvent e, Emitter emit) async {
    emit(state.copyWith(status: AppStatus.pre_req_order, order: e.order));
  }

  Future<void> _haveNewOrder(HaveNewOrderEvent e, Emitter emit) async {
    bool is_recieve_new_order = await appRepository.sendNewOrder(state.order);

    //

    emit(state.copyWith(status: AppStatus.have_new_order));
  }

  Future<void> _previousScreen(PreviousScreenEvent e, Emitter emit) async {
    AppStatus current_status = state.status;
    _set_state(AppStatus cur) {
      if (cur == AppStatus.selected) return AppStatus.create;
      if (cur == AppStatus.create) return AppStatus.order;
      if (cur == AppStatus.pre_req_order) return AppStatus.create;
    }

    ;
    emit(state.copyWith(status: _set_state(current_status)));
  }
}
