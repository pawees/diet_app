import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_app_training/repository/app_repository.dart';
import 'package:game_app_training/repository/models/agency.dart';
import 'package:game_app_training/repository/models/date.dart';
import 'package:game_app_training/repository/models/diets.dart';
import 'package:game_app_training/repository/models/order.dart';
import 'package:game_app_training/repository/models/places.dart';
import 'package:game_app_training/repository/models/result_error.dart';
import 'package:game_app_training/repository/session.dart';
import 'package:game_app_training/ui/app_widget/orderCreateWidget.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:rpc_exceptions/rpc_exceptions.dart';

import 'package:jiffy/jiffy.dart';

import '../../auth_widget/bloc/login_bloc.dart';

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

  Future<void> _refresh_token() async {
    var refreshToken = await _token.token_data.getRefreshToken();
    final new_access_token =
        await appRepository.refreshAccessToken(refreshToken!);
    _token.token_data.setAccessToken(new_access_token.access);
  }

  Future<void> _exceptionsHandler(error) async {
    print('Exceptions handler Active');
    if (error is ErrorConnection) {
      emit(state.copyWith(status: AppStatus.error));
    }

    if (error is RuntimeException) {
      emit(state.copyWith(status: AppStatus.exite));
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: AppStatus.initial));
    } else {
      emit(state.copyWith(status: AppStatus.error)); //FIXME common error
    }
  }

  void _initial() {
    on<AppInitialEvent>(_initialApp);
    on<TapProfileNavEvent>(_getProfile);
    on<TapCreateOrderEvent>(_chooseAgency);
    on<TapNextDateEvent>(_nextDate);
    on<GetMenuEvent>(_getMenu);
    on<ChangeCountEvent>(_changeCount);
    on<NextPlaceEvent>(_nextPlace);
    on<FormOrderEvent>(_formOrder);
    on<HaveNewOrderEvent>(_haveNewOrder);
    on<PreviousScreenEvent>(_previousScreen);
    on<TapAgencyChoiseEvent>(_getOrderScreen);
    on<GetCertainOrderEvent>(_getCertainOrder);
  }

  Future<void> _getOrderScreen(TapAgencyChoiseEvent e, Emitter emit) async {
    emit(state.copyWith(status: AppStatus.loading));
    SmartDialog.dismiss();
    try {
      await _refresh_token();

      var agencies = await appRepository.getAgencies();
      final places = await appRepository.getPlaces(agencies[e.id].uid_1c);
      emit(state.copyWith(
        agency: agencies[e.id], //FIXME temp
        status: AppStatus.create,
        places: places,
      ));
    } catch (error) {
      _exceptionsHandler(error);
    }
  }

  Future<void> _chooseAgency(TapCreateOrderEvent e, Emitter emit) async {
    emit(state.copyWith(
      status: AppStatus.choose_agency,
    ));
  }

  Future<void> _initialApp(AppInitialEvent e, Emitter emit) async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      var user_uid = await appRepository.getUserInfo();
      var agencies = await appRepository.getAgencies();
      //Fake DATA!!!!---------------------------------------------------->
      List<Order> orders = [
        Order(
            id: '1',
            places: [
              Places(name: 'unknow', diets: [Diets(count: 13, name: 'name')])
            ],
            agency_uid: agencies[0].uid_1c,
            date: Date(
                date_for_request: '2022-09-09',
                day_of_week: 'monday',
                dd_mm_yyyy: '2022-09-09'),
            user_uid: '123',
            agency: Agency(
                name: 'Областная больница',
                address: 'ул.Кирова',
                uid_1c: agencies[0].uid_1c)),
        Order(
            id: '1',
            places: [
              Places(name: 'unknow', diets: [Diets(count: 13, name: 'name')])
            ],
            agency_uid: agencies[0].uid_1c,
            date: Date(
                date_for_request: '2022-09-09',
                day_of_week: 'monday',
                dd_mm_yyyy: '2022-09-09'),
            user_uid: '123',
            agency: Agency(
                name: 'Областная больница',
                address: 'ул.Кирова',
                uid_1c: agencies[0].uid_1c)),
        Order(
            id: '1',
            places: [
              Places(name: 'unknow', diets: [Diets(count: 13, name: 'name')])
            ],
            //---------------------------------------------------->
            agency_uid: agencies[0].uid_1c,
            date: Date(
                date_for_request: '2022-09-09',
                day_of_week: 'monday',
                dd_mm_yyyy: '2022-09-09'),
            user_uid: '123',
            agency: Agency(
                name: 'Областная больница',
                address: 'ул.Кирова',
                uid_1c: agencies[0].uid_1c)),
      ];
      //try{}catch get orders.if no orders fetch 'no new orders'.
      //and new orders if exist.

      await Jiffy.locale('ru');
      Date date = Date(
          dd_mm_yyyy: Jiffy().format('dd.MM.yyyy'),
          day_of_week: Jiffy().format('EEEE'),
          date_for_request: Jiffy().format('dd-MM-yyyy'));

      List<Places> listPlaces = [];

      Order order = Order(id: '000-00-0', places: listPlaces);
      emit(state.copyWith(
          status: AppStatus.order,
          order: order,
          user_uid: user_uid,
          date: date,
          agencies: agencies,
          orders: orders));
    } catch (error) {
      _exceptionsHandler(error);
    }
  }

  Future<void> _getProfile(TapProfileNavEvent e, Emitter emit) async {
    emit(state.copyWith(status: AppStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(status: AppStatus.profile));
  }

  Future<void> _nextDate(TapNextDateEvent e, Emitter emit) async {
    await Jiffy.locale('ru');
    Date date = Date(
        dd_mm_yyyy:
            Jiffy().add(duration: Duration(days: e.count)).format('dd.MM.yyyy'),
        day_of_week: Jiffy().add(duration: Duration(days: e.count)).EEEE,
        date_for_request: Jiffy()
            .add(duration: Duration(days: e.count))
            .format('dd-MM-yyyy'));
    var prev = state.date;
    print(prev);
    emit(state.copyWith(status: AppStatus.create, date: date));
  }

  Future<void> _getMenu(GetMenuEvent e, Emitter emit) async {
    //FIXME
    try {
      await _refresh_token();

      emit(state.copyWith(status: AppStatus.loading));
      List<Diets> diets = await appRepository.getDiets();
      emit(state.copyWith(
          status: AppStatus.selected, selected_id: e.id, diets: diets));
    } catch (error) {
      _exceptionsHandler(error);
    }
  }

  Future<void> _getCertainOrder(GetCertainOrderEvent e, Emitter emit) async {
    //FIXME

    try {
      // await _refresh_token();

      // emit(state.copyWith(status: AppStatus.loading));
      emit(state.copyWith(
        status: AppStatus.selected_certain_order,
        selected_order: e.id,
      ));
    } catch (error) {
      _exceptionsHandler(error);
    }
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
    try {
      await _refresh_token();

      bool is_recieve_new_order = await appRepository.sendNewOrder(state.order);
      emit(state.copyWith(status: AppStatus.have_new_order));
    } catch (error) {
      _exceptionsHandler(error);
    }
  }

  Future<void> _previousScreen(PreviousScreenEvent e, Emitter emit) async {
    AppStatus current_status = state.status;
    _set_state(AppStatus cur) {
      if (cur == AppStatus.selected) return AppStatus.create;
      if (cur == AppStatus.create) return AppStatus.order;
      if (cur == AppStatus.pre_req_order) return AppStatus.create;
      if (cur == AppStatus.selected_certain_order) return AppStatus.order;
    }

    ;
    emit(state.copyWith(status: _set_state(current_status)));
  }
}
