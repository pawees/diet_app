part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  success,
  error,
  loading,
  authorized,
  authorizeProc,
  failiture
}

extension LoginStatusX on LoginStatus {
  bool get isInitial => this == LoginStatus.initial;
  bool get isSuccess => this == LoginStatus.success;
  bool get isError => this == LoginStatus.error;
  bool get isLoading => this == LoginStatus.loading;
  bool get isAuth => this == LoginStatus.authorized;
  bool get isNeedAuth => this == LoginStatus.authorizeProc;
  bool get isFailiture => this == LoginStatus.failiture;
}

class LoginState extends Equatable {
  const LoginState({this.status = LoginStatus.initial, this.failiture = null});
  final LoginStatus status;
  final failiture;

  @override
  List<Object?> get props => [status, failiture];

  LoginState copyWith({LoginStatus? status, final failiture}) {
    return LoginState(
        status: status ?? this.status, failiture: failiture ?? this.failiture);
  }
}
