import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:game_app_training/repository/models/agency.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
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

smartDialog(context, state) {
  final appBloc = BlocProvider.of<AppBloc>(context);
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
}
