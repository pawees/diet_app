import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/login_bloc.dart';

class AuthPreloaderWidget extends StatelessWidget {
  const AuthPreloaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .70,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
