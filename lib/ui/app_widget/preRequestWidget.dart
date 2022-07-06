import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';

class PreRequestWidget extends StatelessWidget {
  const PreRequestWidget({Key? key}) : super(key: key);

//from hive insert data
  
  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    _onPressed(){
      appBloc.add(HaveNewOrderEvent());

    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: const Text('123')),
        ElevatedButton(onPressed: _onPressed, child: Text('push me'))
      ],
    );
    
  }
}