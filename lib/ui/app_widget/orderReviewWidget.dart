import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:game_app_training/ui/app_widget/headerWidget.dart';
import 'package:game_app_training/ui/theme/styles.dart';
//add common padding
class PreRequestWidget extends StatelessWidget {
  const PreRequestWidget({Key? key,required this.order,required this.date}) : super(key: key);

  final order;
  //agency
  final date;

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);

    _prev_screen(){
      appBloc.add(PreviousScreenEvent());
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(17, 5, 30, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
            HeaderWidget(title: 'Список заявки'),      
            Text('Дата',style: header1()),
            Text(date),
            // _build_data_widget(call hive order); 
            SizedBox(height: 16,),

            Divider(height: 1,),
                SizedBox(height: 16,),
                Text('Учреждение',style: header1()),
                SizedBox(height: 16,),
                _Agency(title: 'ДДЦ Центр здоровья для детей', address:'610027,Кировская область,г.Киров,ул Красноармейская,43'),
                SizedBox(height: 20,),
                Divider(height: 1,),
                SizedBox(height: 16,),
                Text('Отделения',style: header1()),
                SizedBox(height: 25,),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {

                          if(index == order.places.length){
                            return SendOrderWidget();
                          }
                          return _BuildOrderWidget (data: order.places[index], selected: index);
                          },
                      itemCount: order.places.length + 1), //places.length,),
                ),  
          
        ],
      ),
    ); 
  }
}


class _BuildOrderWidget extends StatelessWidget {
  const _BuildOrderWidget({Key? key, this.data,this.selected}) : super(key: key);
  final data;
  final selected;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: 
    <Widget>[Text(data.name,style: h18_500()),SizedBox(height: 24),for(var item in data.diets )
    
     Column(
      children: [SizedBox(height: 16,),
        Row(children:[Expanded(child: Text(item.name,style: header2(),)), Text(item.count.toString(),style: h18_500())]),
      ],
    ),
    SizedBox(height: 24,),
    Divider(height: 1,),
    SizedBox(height: 24,)],);
    // return Container(child: Column(children: <Widget>[Text(data.name), Column(children: data.diets.map((item) => Text(item.name)).toList())],),);
  }
}


class _Agency extends StatelessWidget {
  const _Agency({Key? key,
  this.title,this.address}) : super(key: key);

  final title;
  final address;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
      ],
    );
  }
}


class SendOrderWidget extends StatelessWidget {
  const SendOrderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    _onPressed(){
      appBloc.add(HaveNewOrderEvent(''));

    }
    return ElevatedButton(onPressed: _onPressed, child: Text('push me'));
  } 
}