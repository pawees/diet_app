part of 'login_bloc.dart';

enum LoginStatus { initial, success, error, loading, authorized, authorizeProc }

extension LoginStatusX on LoginStatus {
  bool get isInitial => this == LoginStatus.initial;
  bool get isSuccess => this == LoginStatus.success;
  bool get isError => this == LoginStatus.error;
  bool get isLoading => this == LoginStatus.loading;
  bool get isAuth => this == LoginStatus.authorized;
  bool get isNeedAuth => this == LoginStatus.authorizeProc;
}

class LoginState extends Equatable {
  const LoginState({this.status = LoginStatus.initial});
  final LoginStatus status;

  @override
  List<Object?> get props => [status];

  LoginState copyWith({
    LoginStatus? status,
  }) {
    return LoginState(
      status: status ?? this.status,
    );
  }
}
