import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/auth_widget/authScreenWidget.dart';
import 'package:game_app_training/ui/auth_widget/authPreloaderWidget.dart';
import 'package:game_app_training/ui/auth_widget/authErrorWidget.dart';


import 'bloc/login_bloc.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state.status.isNeedAuth) {
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: AuthScreenWidget());
        }
        if (state.status.isSuccess) {
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(child:Text('OrderPage')));
        } 
        if (state.status.isError) {
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: AuthErrorWidget() );
        }
        if (state.status.isLoading) {
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const AuthPreloaderWidget());
        }else {
          return const SizedBox();
        }
      },
    );
  }
}
