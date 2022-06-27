part of 'login_bloc.dart';

abstract class LoginEvent {}

class IsAuth extends LoginEvent {}

class ShowSnackBarEvent extends LoginEvent {}

class AuthorizeEvent extends LoginEvent {
  final String password;
  final String phone;
  var passwordController;

  AuthorizeEvent(this.password, this.phone, this.passwordController);
}
