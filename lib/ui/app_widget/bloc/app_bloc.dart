import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_app_training/repository/app_repository.dart';
import 'package:game_app_training/repository/models/agency.dart';
import 'package:game_app_training/repository/models/date.dart';
import 'package:game_app_training/repository/models/dietCategories.dart';
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

  Future<void> _exceptionsHandler(error,e,emit) async {
    print('Exceptions handler Active');
    if (error is ErrorConnection) {
      emit(state.copyWith(status: AppStatus.error));
    }
    if (error is ErrorSendOrder){
      emit(state.copyWith(status: AppStatus.create_order_err));



    }
    if (error is RuntimeException) {
      emit(state.copyWith(status: AppStatus.exite));

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
    on<EditOrderEvent>(_editOrder);
    on<CopyAndCreateEvent>(_copyAndCreate);
  }
  
  Future<void> _getOrderScreen(TapAgencyChoiseEvent e, Emitter emit) async {

      emit(state.copyWith(status: AppStatus.loading));

    
    SmartDialog.dismiss();

    state.copyWith(edited: false);

    try {
      await _refresh_token();

      var agencies = await appRepository.getAgencies();
      final places = await appRepository.getPlaces(agencies[e.id].uid_1c);

      // diets = await appRepository.getDiets(agencies[e.id].uid_1c);
      // for (var i in places){
      // List<Diets> d = [];

      //   for(var i in diets){
      //     d.add(Diets(count: 0,pk: 0,uid: '',name: ''));
      //   }
      //   i.diets = d;//await appRepository.getDiets(order.agency!.uid_1c);
      // }

      emit(state.copyWith(status: AppStatus.loading));

      emit(state.copyWith(
        agency: agencies[e.id], //FIXME temp
        status: AppStatus.create,
        places: places,
        title: 'Новая заявка'
      ));
    } catch (error) {
      _exceptionsHandler(error,e ,emit);
    }
  }

  Future<void> _chooseAgency(TapCreateOrderEvent e, Emitter emit) async {
    emit(state.copyWith(date_counter: 0));
         Date date = Date(
          dd_mm_yyyy: Jiffy().format('dd.MM.yyyy'),
          day_of_week: Jiffy().format('EEEE'),
          date_for_request: Jiffy().format('yyyy-MM-dd'));
    emit(state.copyWith(date: date));
    emit(state.copyWith(
      status: AppStatus.choose_agency,
    ));
  }


  Future<void> _initialApp(AppInitialEvent e, Emitter emit) async {

    emit(state.copyWith(status: AppStatus.loading));
    try {
      var user_uid = await appRepository.getUserInfo();
      var agencies = await appRepository.getAgencies();

     List<Order> get_orders = await appRepository.getOrders();



  
      Date date = Date(
          dd_mm_yyyy: Jiffy().format('dd.MM.yyyy'),
          day_of_week: Jiffy().format('EEEE'),
          date_for_request: Jiffy().format('yyyy-MM-dd'));

      List<Places> listPlaces = [];

      Order order = Order(pk:0, id: '000-00-0', places: listPlaces);
      emit(state.copyWith(
          status: AppStatus.order,
          order: order,
          user_uid: user_uid,
          date: date,
          agencies: agencies,
          orders: get_orders,
          date_counter: 0));
    } catch (error) {
      _exceptionsHandler(error,e,emit);
    }
  }


  Future<void> _getProfile(TapProfileNavEvent e, Emitter emit) async {
    emit(state.copyWith(status: AppStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(status: AppStatus.profile));
  }


  Future<void> _nextDate(TapNextDateEvent e, Emitter emit) async {
    if (e.increment){
    emit(state.copyWith(date_counter: state.date_counter + 1));
    }else{
        emit(state.copyWith(date_counter: state.date_counter - 1));

    }
    
    Date date = Date(
        dd_mm_yyyy:
            Jiffy().add(duration: Duration(days: state.date_counter)).format('dd.MM.yyyy'),
        day_of_week: Jiffy().add(duration: Duration(days: state.date_counter)).EEEE,
        date_for_request: Jiffy()
            .add(duration: Duration(days: state.date_counter))
            .format('yyyy-MM-dd'));
    emit(state.copyWith(status: AppStatus.create, date: date));
  }


  Future<void> _getMenu(GetMenuEvent e, Emitter emit) async {

    try {
      await _refresh_token();

      emit(state.copyWith(status: AppStatus.loading));
      
      List<CategoryDiet> peoples = await appRepository.getPeopleCategory(state.agency!.uid_1c);

      emit(state.copyWith(
          status: AppStatus.selected, selected_id: e.id, categories: peoples));
    } catch (error) {
      _exceptionsHandler(error,e,emit);
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
        title: 'Номер заявки №'
      ));
    } catch (error) {
      _exceptionsHandler(error,e,emit);
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
 //тупое название

  Future<void> _haveNewOrder(HaveNewOrderEvent e, Emitter emit) async {
    SmartDialog.dismiss();


    emit(state.copyWith(status: AppStatus.loading));
    try {
      await _refresh_token();
      
      if(state.edited!){
        bool is_recieve_edited_order = await appRepository.sendEditedOrder(state.order,state);
      }else{
      if (e.date !=''){
        Date date = Date(date_for_request: e.date, day_of_week: e.date,dd_mm_yyyy: e.date);
        state.order!.date = date;
      }
      bool is_recieve_new_order = await appRepository.sendNewOrder(state.order,state);
      //check for null
      }
      List<Order> get_orders = await appRepository.getOrders();
      emit(state.copyWith(status: AppStatus.have_new_order, orders: get_orders, edited: false));
      


    } catch (error) {
      _exceptionsHandler(error,e,emit);
      SmartDialog.dismiss();

    }
  }


  Future<void> _previousScreen(PreviousScreenEvent e, Emitter emit) async {
    AppStatus current_status = state.status;
    _set_state(AppStatus cur) {
      if (cur == AppStatus.selected) return AppStatus.create;
      if (cur == AppStatus.create) 
      {
        emit(state.copyWith(date_counter: 0));
         Date date = Date(
          dd_mm_yyyy: Jiffy().format('dd.MM.yyyy'),
          day_of_week: Jiffy().format('EEEE'),
          date_for_request: Jiffy().format('yyyy-MM-dd'));
        emit(state.copyWith(date: date));
        return AppStatus.order;
        
        }
      if (cur == AppStatus.pre_req_order) return AppStatus.create;
      if (cur == AppStatus.selected_certain_order) return AppStatus.order;
    }

    emit(state.copyWith(status: _set_state(current_status)));
  }


  Future<void> _editOrder(EditOrderEvent e, Emitter emit) async {

      emit(state.copyWith(status: AppStatus.loading));
      
      Order order = state.orders![e.id];
      final places = await appRepository.getPlaces(order.agency!.uid_1c);
      List<Diets> diets = await appRepository.getDiets(order.agency!.uid_1c);
      for (var i in places){
      List<Diets> d = [];

        for(var i in diets){
          d.add(Diets(count: i.count,pk: i.pk,uid: i.uid,name:i.name));
        }
        i.diets = d;//await appRepository.getDiets(order.agency!.uid_1c);
      }

      for(var i in order.places!){
        places.removeWhere((item) => item.name == i.name);
        places.add(i);
        }

       emit(state.copyWith(date_counter: 0));

    
    emit(state.copyWith(
      status: AppStatus.create,
      places: places,
      agency: order.agency,
      title: 'Редактировать заявку',
      date: order.date,
      order: order,
      edited: true));
}

 Future<void> _copyAndCreate(CopyAndCreateEvent e, Emitter emit) async {
    //selected id packed order like above
    emit(state.copyWith(status: AppStatus.loading));
      
      Order order = state.orders![state.selected_order];
      var user_uid = await appRepository.getUserInfo();
      order.user_uid = user_uid;
      final places = await appRepository.getPlaces(order.agency!.uid_1c);
      List<Diets> diets = await appRepository.getDiets(order.agency!.uid_1c);
      List<CategoryDiet> peoples = await appRepository.getPeopleCategory(order.agency!.uid_1c);

      for (var i in places){
      List<Diets> d = [];

        for(var i in diets){
          d.add(Diets(count: i.count,pk: i.pk,uid: i.uid,name:i.name));
        }
        i.diets = d;//await appRepository.getDiets(order.agency!.uid_1c);
      }

      for(var i in order.places!){
        places.removeWhere((item) => item.name == i.name);
        places.add(i);
        }

       emit(state.copyWith(date_counter: 0));

    
      emit(state.copyWith(
      status: AppStatus.date_choose,
      places: places,
      agency: order.agency,
      date: order.date,
      order: order,
      categories: peoples,
      edited: false));
 }



}
