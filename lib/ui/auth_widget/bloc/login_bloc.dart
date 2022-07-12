import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_app_training/repository/app_repository.dart';
import 'package:game_app_training/repository/models/order.dart';
import 'package:game_app_training/repository/session.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.appRepository,
  }) : super(LoginState()) {
    on<LoginEvent>(_loginEventHandler);
    _initial();
  }
  
  final GameRepository appRepository;
  final _token = SessionState();


  
  void _initial() {
    on<AuthorizeEvent>(_loginButtonTapped);
    on<ShowSnackBarEvent>(_showSnackBarTapped);
    on<IsAuth>(_isAuth);
  }

  Future<void> _isAuth(LoginEvent e, Emitter emit) async {
    //берем рефреш токен - если нет,то на страницу авторизации
    //обновляем ацесс токен - если нет,то на страницу авторизации
    //делаем запрос на получение - если нет,то на страницу авторизации
    //делаем запрос на получение активных заявок - сохраняем их в стэйт.
    //если их нет,то рисуем экран новых заявок нет
    //
    emit(state.copyWith(status: LoginStatus.loading));

    try{

      var refreshToken = await _token.token_data.getRefreshToken();
      final new_access_token = await appRepository.refreshAccessToken(refreshToken!);
      _token.token_data.setAccessToken(new_access_token.access);


      //save to state uid from this method
      await appRepository.getUserInfo();
      List<Order> orders = await appRepository.getNewOrders();


      emit(state.copyWith(status: LoginStatus.success));

   }catch(e){

      emit(state.copyWith(status: LoginStatus.authorizeProc));
   
   }

    // var q = await _token.token_data.getAccessToken();
    // var q1 = 1;
    
    
    // emit(state.copyWith(status: LoginStatus.loading));
    // await Future.delayed(const Duration(seconds: 2));
    // emit(state.copyWith(status: LoginStatus.success));
    // await Future.delayed(const Duration(seconds: 2));
    
    // try {
    //      final login = await appRepository.getToken();
    //      await _token.token_data.setAccessToken(login.access);
    //      emit(state.copyWith(status: LoginStatus.success));
    // }catch(error){
    //   print(error);
    //   emit(state.copyWith(status: LoginStatus.error));
    // }
   
    // emit(state.copyWith(status: LoginStatus.authorizeProc));
    // emit(state.copyWith(status: LoginStatus.loading));
    // try {
    //   // final loginToken = await Repository.getToken();
    //   emit(state.copyWith(status: LoginStatus.loading));
    //   await Future.delayed(const Duration(seconds: 2));
    //   final login = await appRepository.getToken();
    //   await _token.token_data.setAccessToken('z1asd434');
    //   var qwe = await _token.token_data.getAccessToken();
    //   var q11 = '132';
      
    //   // emit(state.copyWith(status: LoginStatus.success));
    // } catch (error, stacktrace) {
    //   print(error);
    //   emit(state.copyWith(status: LoginStatus.error));
    // }
  }

  Future<void> _loginEventHandler(LoginEvent e, Emitter emit) async {
    // emit(LoginInitial());
  }

  Future<void> _showSnackBarTapped(ShowSnackBarEvent e, Emitter emit) async {
    // emit(ShowSnackbarState());
  }

  Future<void> _loginButtonTapped(AuthorizeEvent e, Emitter emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {//FIXME
      //NEED
      // from e.login/password
      // then e.passwordControlle.clean()
      final loginToken = await appRepository.getToken();
      await _token.token_data.setAccessToken(loginToken.access);
      await _token.token_data.setRefreshToken(loginToken.refresh);
      emit(state.copyWith(status: LoginStatus.success));
    } catch (error, stacktrace) {
      
      print(stacktrace);
      emit(state.copyWith(status: LoginStatus.error));
      //LiginStatus.error must be AlertDialog, -> LoginBuilder-should stay LoginConsumer.
    }
   
  }
}
