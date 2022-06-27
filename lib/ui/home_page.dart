import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:game_app_training/ui/home_layout.dart';
import 'package:game_app_training/repository/app_repository.dart';
import 'package:game_app_training/repository/service.dart';
import 'package:game_app_training/ui/auth_widget/bloc/login_bloc.dart';

import 'auth_widget/bloc/login_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RepositoryProvider(
        create: (context) => GameRepository(service: GameService()),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(
                appRepository: context.read<GameRepository>(),
              )..add(
                  IsAuth(),
                ),
            ),
            BlocProvider<AppBloc>(
              create: (context) => AppBloc(
                appRepository: context.read<GameRepository>(),
              )..add(
                  AppInitialEvent(),
                ),
            ),
          ],
          child: HomeLayout(),
        ),
      ),
      
    );
  }
}
