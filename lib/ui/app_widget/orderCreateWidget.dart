import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:game_app_training/ui/theme/styles.dart';
import 'package:game_app_training/repository/models/places.dart';

class OrderCreateWidget extends StatelessWidget {
  const OrderCreateWidget({
    Key? key,
    required this.places,
    }) : super(key: key);
    
    final places;
  
  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    _on_pressed(){
      appBloc.add(PreviousScreenEvent());
    }
    return BlocBuilder<AppBloc,AppState>(
      builder: (context,state) {
        return Scaffold(
          appBar:AppBar(
            leading:  IconButton(
              icon: ImageIcon(AssetImage('assets/images/chevron.png')),
              onPressed: _on_pressed,),
            title: Transform(
              transform:  Matrix4.translationValues( MediaQuery.of(context).size.width/6, 0.0, 0.0),
              child: Text(
                  'Новая заявка',
              style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
                      ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(17, 5, 30, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Дата',style: header1()),
                SizedBox(height: 12,),
                _buildDateWidget(state),
                // DateWidget(date: state.date!),
                SizedBox(height: 21,),
                Divider(height: 1,),
                SizedBox(height: 16,),

                Text('Учреждение',style: header1()),
                SizedBox(height: 16,),
                Agency(title: 'ДДЦ Центр здоровья для детей', address:'610027,Кировская область,г.Киров,ул Красноармейская,43'),
                SizedBox(height: 20,),
                Divider(height: 1,),
                SizedBox(height: 20,),
                Text('Отделения',style: header1()),
                SizedBox(height: 25,),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                          return PlacesWidget(data: places[index], selected: index);
                          },
                      itemCount: places.length,),
                ),
              ],
            ),
          ),
      );
      }
    );
  }

}

class PlacesWidget extends StatelessWidget {
  const PlacesWidget({Key? key, required this.data, required this.selected}) : super(key: key);
 final data;
 final int selected;
  
  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);

    _get_menu(){
      appBloc.add(GetMenuEvent(selected));//probaly need some id.
    }

    return GestureDetector(
      onTap: _get_menu,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(height: 12.5,),
        Row(
           children: [
             Expanded(child: Text(data.name)),
             SizedBox.fromSize(size:Size.fromRadius(13),child: FittedBox(child: Icon(Icons.chevron_right_sharp))),]
             ),
        SizedBox(height: 12.5,),
        Divider(height: 1,)
          ],
    
    
      ),
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
int count = 0;


class DateWidget extends StatelessWidget {
  const DateWidget({Key? key,
  required this.date,}) : super(key: key);

  final String date;

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    
    _next(){
      count+=1;
      appBloc.add(TapNextDateEvent(count));

    };
    
    _prev(){
      if (count==0) return;
      count-=1;
      appBloc.add(TapNextDateEvent(count));
    };
    return Row(
      children: 
      [
        IconButton(onPressed: _prev, icon: Icon(Icons.chevron_left_sharp)),
        Expanded(child: Column(children: [Text(date),Text('сегодняшнее число'),],)),
        IconButton(onPressed: _next, icon: Icon(Icons.chevron_right_sharp)),

        
        ],
        );
  }
}


 _buildDateWidget( AppState state) {
    if (state.status.isCreate){
      return DateWidget(date: state.date!);
    }
    }
    