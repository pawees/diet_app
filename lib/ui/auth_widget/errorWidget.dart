import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/login_bloc.dart';

class NotConnectErrorWidget extends StatelessWidget {
  const NotConnectErrorWidget({Key? key,this.state}) : super(key: key);
  final state;
  @override
  Widget build(BuildContext context) {
    _onPressed() {
      //loginBloc.isAuth
    }
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state.status.isError) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.failure.toString()),
                  ElevatedButton(
                      onPressed: _onPressed, child: Text('Попробовать ещё'))
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
