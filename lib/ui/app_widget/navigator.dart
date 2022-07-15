import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:game_app_training/repository/models/agency.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/menuWidget.dart';
import 'package:game_app_training/ui/app_widget/orderCreateWidget.dart';
import 'package:game_app_training/ui/app_widget/orderWidget.dart';
import 'package:game_app_training/ui/app_widget/popupWidget/dialog_got_agency.dart';
import 'package:game_app_training/ui/app_widget/preRequestWidget.dart';
import 'package:game_app_training/ui/app_widget/profileWidget.dart';
import 'package:game_app_training/ui/theme/styles.dart';

class _agenciesListWidget extends StatelessWidget {
  _agenciesListWidget(
      {Key? key,
      required this.bloc,
      required this.agency,
      required this.selected})
      : super(key: key);

  final AppBloc bloc;
  final Agency agency;
  final int selected;

  @override
  Widget build(BuildContext context) {
    _get_agency() {
      bloc.add(TapAgencyChoiseEvent(selected));
    }

    return GestureDetector(
      onTap: _get_agency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            agency.name.toString(),
            style: h17_400(),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            agency.address.toString(),
            style: h13_400(),
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({Key? key}) : super(key: key);

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);

    void onSelected(int index) {
      if (_selected == index) return;

      setState(() {
        _selected = index;
      });
      if (_selected == 0) {
        appBloc.add(AppInitialEvent());
      }
      if (_selected == 2) {
        appBloc.add(TapProfileNavEvent());
      }
      ;
    }

    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state.status.ischooseAgency) {
          final appBloc = BlocProvider.of<AppBloc>(context);

          _chosedAgency() {
            appBloc.add(AppInitialEvent()); //FIXME temp
            // SmartDialog.dismiss();
          }

          SmartDialog.show(
              useAnimation: true,
              clickMaskDismiss: false,
              builder: (_) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        height: 300, //FIXME
                        width: 500,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            color: Colors.white),
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    'Выберите учреждение',
                                    style: h20_600(),
                                  )),
                                  IconButton(
                                      onPressed: () {
                                        appBloc.add(AppInitialEvent());
                                        SmartDialog.dismiss();
                                      },
                                      icon: const Icon(Icons.close_rounded)),
                                ],
                              ),
                              Expanded(
                                  child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return _agenciesListWidget(
                                            bloc: appBloc,
                                            agency: state.agencies[index],
                                            selected: index);
                                      },
                                      itemCount: state.agencies.length)),
                            ],
                          ),
                        )),
                  ],
                );
              });
          // showDialog(
          //     barrierDismissible: false,
          //     context: context,
          //     builder: (_) {
          //       return AlertDialog(
          //           title: const Text('AlertDialog Title'),
          //           content: const Text('123'),
          //           actions: [
          //             TextButton(onPressed: () {}, child: Text('add'))
          //           ]);
          //     });
        }
      },
      builder: (context, state) {
        return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
          return Scaffold(
            body: _buildScreensWidget(state),
            // bottomNavigationBar: BottomNavigationBar(
            //   items: [
            //     BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/union.png'),), label:'Заявки'),
            //     BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/qr_code.png')), label:'QR-коод'),
            //     BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/profile.png')), label:'Профиль'),
            //   ],
            //   currentIndex: _selected,
            //   onTap: onSelected,
            // ),
          );
        });
      },
    );
  }

  _buildScreensWidget(AppState state) {
    if (state.status.ischooseAgency) {
      return OrderWidget();
    }
    if (state.status.isOrder) {
      return OrderWidget();
    }
    if (state.status.isProfile) {
      return ProfileWidget();
    }
    if (state.status.isCreate) {
      return OrderCreateWidget(places: state.places);
    }
    if (state.status.isSelected) {
      return MenuChoiseWidget();
    }
    if (state.status.isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      );
    }
    if (state.status.isPreRequestOrder) {
      return PreRequestWidget(order: state.order!, date: state.date!);
    }
    if (state.status.isNewOrder) {
      return OrderWidget();
    }
  }
}
