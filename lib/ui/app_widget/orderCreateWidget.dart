import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:jiffy/jiffy.dart';

class OrderCreateWidget extends StatelessWidget {
  const OrderCreateWidget({
    Key? key,
    required this.places,
    }) : super(key: key);
    
    final List<String> places;
  
  @override
  Widget build(BuildContext context) {
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
          body: Padding(
            padding: const EdgeInsets.fromLTRB(17, 5, 30, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Дата',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600 ),),
                SizedBox(height: 12,),
                DateWidget(),
                SizedBox(height: 21,),
                Divider(height: 1,),
                SizedBox(height: 16,),

                Text('Учреждение',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600 ),),
                SizedBox(height: 16,),
                Agency(title: 'ДДЦ Центр здоровья для детей', address:'610027,Кировская область,г.Киров,ул Красноармейская,43'),
                SizedBox(height: 20,),
                Divider(height: 1,),
                SizedBox(height: 20,),
                Text('Отделения',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600 ),),
                SizedBox(height: 25,),
                Container(
                  height: double.infinity,
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                          return Places(data: places[index],);
                          },
                      itemCount: places.length,    ),
                ),
              ],
            ),
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
      SizedBox(height: 12.5,),
      Row(
         children: [
           Expanded(child: Text(data)),
           SizedBox.fromSize(size:Size.fromRadius(13),child: FittedBox(child: Icon(Icons.chevron_right_sharp))),]
           ),
      SizedBox(height: 12.5,),
      Divider(height: 1,)
      // Container(
      //   height: 0.3,
      //   width: 350,
      //   decoration: BoxDecoration(color: Color.fromARGB(255, 104, 105, 105),
      //       ),)  
        ],


    );
    
  }
}
class Agency extends StatelessWidget {
  const Agency({Key? key,
  this.title,this.address}) : super(key: key);

  final title;
  final address;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.sunny),
        SizedBox(width: 10,),
        
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              SizedBox(height: 4,),
              SizedBox(width:250,child: Text(address,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: Colors.grey),)),
        
            ],
          ),
        ),
        Icon(Icons.pan_tool_alt),
      ],
    );
  }
}

class DateWidget extends StatelessWidget {
  const DateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: 
      [
        IconButton(onPressed: (){}, icon: Icon(Icons.chevron_left_sharp)),
        Expanded(child: Column(children: [Text(Jiffy().format('MMM do yy')),Text('сегодняшнее число'),],)),
        IconButton(onPressed: (){}, icon: Icon(Icons.chevron_right_sharp)),
        
        ],
        );

    
  }
}