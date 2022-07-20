import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:game_app_training/ui/app_widget/menuWidget.dart';
import 'package:game_app_training/ui/app_widget/navigator.dart';
import 'package:game_app_training/ui/app_widget/orderCreateWidget.dart';
import 'package:game_app_training/ui/app_widget/popupWidget/modalWindowsWidget.dart';
import 'package:game_app_training/ui/app_widget/preRequestWidget.dart';
import 'package:game_app_training/ui/auth_widget/authScreenWidget.dart';
import 'package:game_app_training/ui/auth_widget/errorWidget.dart';
import 'package:game_app_training/ui/auth_widget/authPreloaderWidget.dart';
import 'package:game_app_training/ui/auth_widget/bloc/login_bloc.dart';
import 'package:game_app_training/ui/loadingWidget.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          SmartDialog.showToast(state.failure.toString());
        }


        // if (state.status.isLoading) {
        //   SmartDialog.showLoading(msg: 'Загрузка...');
        // }
      },
      builder: (context, state) {
        return BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (loginBloc.state.status.isNeedAuth) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: AuthScreenWidget());
            }
            // if (loginBloc.state.status.isNeedAuth &&
            //     appBloc.state.status.isInitial) {
            //   return AuthScreenWidget();
            // }
            if (loginBloc.state.status.isSuccess) {
              appBloc.add(AppInitialEvent());
              return const NavigatorBar();
            }

            if (loginBloc.state.status.isError) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: NotConnectErrorWidget());
            }
            if (loginBloc.state.status.isLoading) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const AuthPreloaderWidget());
            }
            // if (loginBloc.state.status.isSuccess &&
            //     appBloc.state.status.isOrder) {
            //   return NavigatorBar();
            // }
            // if (loginBloc.state.status.isSuccess &&
            //     appBloc.state.status.isProfile) {
            //   return NavigatorBar();
            // }
            if (loginBloc.state.status.isSuccess &&
                appBloc.state.status.isCreate) {
              return OrderCreateWidget(
                places: appBloc.state.places!,
              );
            }
            // if (loginBloc.state.status.isSuccess &&
            //     appBloc.state.status.isPreRequestOrder) {
            //   return PreRequestWidget(
            //       order: appBloc.state.order!, date: appBloc.state.date!);
            // }
            if (loginBloc.state.status.isSuccess &&
                appBloc.state.status.isSelected) {
              return MenuChoiseWidget();
            } else {
              return const LoadingWidget();
            }
          },
        );
      },
    );
  }
}
