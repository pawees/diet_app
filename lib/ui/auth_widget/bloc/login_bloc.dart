import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_app_training/repository/app_repository.dart';
import 'package:game_app_training/repository/models/agency.dart';
import 'package:game_app_training/repository/models/diets.dart';
import 'package:game_app_training/repository/models/order.dart';
import 'package:game_app_training/repository/models/result_error.dart';
import 'package:game_app_training/repository/session.dart';
import 'package:jsonrpc2/jsonrpc2.dart';
import 'dart:convert';

import 'package:rpc_exceptions/rpc_exceptions.dart';
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
  //final _token = SessionState();

  void _initial() {
    on<AuthorizeEvent>(_loginButtonTapped);
    on<ShowSnackBarEvent>(_showSnackBarTapped);
    on<IsAuth>(_isAuth);
  }

  Future<void> _isAuth(LoginEvent e, Emitter emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    //FIXME вместо лоадинг нужна красивая картинка роспитание.

    try {
      //var refreshToken = _token.token_data.getRefreshToken();
      var refreshToken = token.refreshToken;
      final new_access_token =
          await appRepository.refreshAccessToken(refreshToken!);
      token.accessToken = new_access_token.access;

      await appRepository.getUserInfo();

      emit(state.copyWith(status: LoginStatus.success));
    } catch (error) {
      print(error);

      if (error is ErrorConnection) {
        emit(state.copyWith(status: LoginStatus.error));
      } else {
        emit(state.copyWith(status: LoginStatus.authorizeProc));
      }
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
    try {
      //FIXME
      //NEED
      // from e.login/password
      // then e.passwordControlle.clean()
      final loginToken = await appRepository.getToken();
      token.accessToken = loginToken.access;
      token.refreshToken = loginToken.refresh;

      emit(state.copyWith(status: LoginStatus.success));
    } on Exception catch (error, _) {
      if (error is ErrorConnection) {
        emit(state.copyWith(status: LoginStatus.error));
      }
      if (error is RuntimeException){ 
        final e = 'Неправильный логин или пароль...';
        emit(state.copyWith(status: LoginStatus.failure, failure: e));
        emit(state.copyWith(status: LoginStatus.authorizeProc));
      }else{
 
        emit(state.copyWith(status: LoginStatus.error, failure: error.toString()));
      }}
  }
}
