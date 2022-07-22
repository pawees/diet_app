part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  success,
  error,
  loading,
  authorized,
  authorizeProc,
  failure
}

extension LoginStatusX on LoginStatus {
  bool get isInitial => this == LoginStatus.initial;
  bool get isSuccess => this == LoginStatus.success;
  bool get isError => this == LoginStatus.error;
  bool get isLoading => this == LoginStatus.loading;
  bool get isAuth => this == LoginStatus.authorized;
  bool get isNeedAuth => this == LoginStatus.authorizeProc;
  bool get isFailure => this == LoginStatus.failure;
}

class LoginState extends Equatable {
  const LoginState({this.status = LoginStatus.initial, this.failure = null});
  final LoginStatus status;
  final String? failure;

  @override
  List<Object?> get props => [status, failure];

  LoginState copyWith({LoginStatus? status, final failure}) {
    return LoginState(
        status: status ?? this.status, failure: failure ?? this.failure);
  }
}
