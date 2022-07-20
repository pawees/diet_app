import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:game_app_training/ui/theme/styles.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  
  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);

    _prev_screen() {
      appBloc.add(PreviousScreenEvent());
    }

    return SafeArea(
        child: Column(children: [
      Row(
        children: [
          IconButton(
              iconSize: 16.3,
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              alignment: Alignment.centerLeft,
              icon: ImageIcon(AssetImage('assets/images/chevron.png')),
              onPressed: _prev_screen),

          Expanded(child: Text(title, style: h17_600())),
          const SizedBox(
            height: 10,
          )
        ],
      ),
      const Divider(
        height: 3,
      ),
      const SizedBox(
        height: 20,
      )
    ]));
  }
}
