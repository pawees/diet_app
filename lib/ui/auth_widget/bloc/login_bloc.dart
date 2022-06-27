import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_app_training/repository/app_repository.dart';

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

  void _initial() {
    on<AuthorizeEvent>(_loginButtonTapped);
    on<ShowSnackBarEvent>(_showSnackBarTapped);
    on<IsAuth>(_isAuth);
  }

  Future<void> _isAuth(LoginEvent e, Emitter emit) async {
    // do some check user for authorization
    // emit(AuthorizeState(msg: "login_sucess"));
    emit(state.copyWith(status: LoginStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(status: LoginStatus.authorizeProc));
  }

  Future<void> _loginEventHandler(LoginEvent e, Emitter emit) async {
    // emit(LoginInitial());
  }

  Future<void> _showSnackBarTapped(ShowSnackBarEvent e, Emitter emit) async {
    // emit(ShowSnackbarState());
  }

  Future<void> _loginButtonTapped(AuthorizeEvent e, Emitter emit) async {
    // emit(ShowSnackbarLoadingState()); prev implement
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      // final loginToken = await Repository.getToken();
      emit(state.copyWith(status: LoginStatus.loading));
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: LoginStatus.success));
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(status: LoginStatus.error));
    }
    // if (e.password != '123') {
    //   emit(ShowSnackbarLoadingState());
    //   await Future.delayed(const Duration(seconds: 4));
    //   emit(AuthorizeState(msg: "login_sucess"));
    // } else {
    //   e.passwordController.clear();
    //   emit(ShowSnackbarState());
    // }
  }
}
