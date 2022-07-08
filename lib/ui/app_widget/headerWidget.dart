import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
 

    _prev_screen(){
          appBloc.add(PreviousScreenEvent());
    }
    return SafeArea(

      child: Column(
        children: [
                  Row(children: [
            IconButton(
                iconSize: 16.3,
                padding: const EdgeInsets.symmetric(horizontal:0.0),
                alignment: Alignment.centerLeft,
                icon: ImageIcon(AssetImage('assets/images/chevron.png')),
                onPressed: _prev_screen),
            Transform(
              transform:  Matrix4.translationValues( MediaQuery.of(context).size.width/7, 0.0, 0.0),
              child:  Text(title,
                  style: TextStyle(
                    color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
                          ),
            ),
            SizedBox(height: 10,)    
                ],),
            Divider(height: 3,),
            
            SizedBox(height: 20,)    
            
            ]

      ));
}
}

