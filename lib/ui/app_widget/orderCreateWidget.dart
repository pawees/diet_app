import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';


class OrderCreateWidget extends StatelessWidget {
  const OrderCreateWidget({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  final List<String> data = ["Хирургия(Взрослые)","Наркология(Взрослые)","Детское(Дети,Роженицы)","Травматология(Взрослые)",
  "Хирургия(Взрослые)","Наркология(Взрослые)","Детское(Дети,Роженицы)","Травматология(Взрослые)"];
  print(data.length);
    return BlocBuilder<AppBloc,AppState>(
      builder: (context,state) {
        return Scaffold(
          appBar:AppBar(
            title: const Center(
              child: Text(
                  'Новая заявка',
              style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          )),),
          body: Container(
            height: 300,
            child: 
            ListView.separated(
               padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              top: 24.0,
            ),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                    return Places(data: data[index],);
                    },
                separatorBuilder: (_, __) => SizedBox(height: 20.0,),
                itemCount: data.length,    )
          ),
      );
      }
    );
  }

}

class Places extends StatelessWidget {
  const Places({Key? key, required this.data,}) : super(key: key);
  final String data;
  
  @override
  Widget build(BuildContext context) {


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 35),
         child: SizedBox(height: 30,width: 300,child: Row(
          children: [
            SizedBox(height: 10,),
            Expanded(child: Text(data)),
            Icon(Icons.chevron_right_sharp),]
            ),
            ),
    
       ),

        ],
    );
    
  }
}


