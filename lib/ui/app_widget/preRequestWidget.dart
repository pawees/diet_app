import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
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
    _onPressed(){
      appBloc.add(HaveNewOrderEvent());

    }
    _prev_screen(){
      appBloc.add(PreviousScreenEvent());
    }
    return SafeArea(

      child: Column(
        children: [
                  Row(children: [
            IconButton(
                icon: ImageIcon(AssetImage('assets/images/chevron.png')),
                onPressed: _prev_screen),
            Transform(
              transform:  Matrix4.translationValues( MediaQuery.of(context).size.width/5, 0.0, 0.0),
              child: const Text('Список заявки',
                  style: TextStyle(
                    color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
                          ),
            ),    
                ],),
            Divider(height: 3,),
            Text('Дата',style: header1()),
            Text(date),
            // _build_data_widget(call hive order); 
            //Divider(height: 1,),
                SizedBox(height: 16,),

                Text('Учреждение',style: header1()),
                SizedBox(height: 16,),
                _Agency(title: 'ДДЦ Центр здоровья для детей', address:'610027,Кировская область,г.Киров,ул Красноармейская,43'),
                SizedBox(height: 20,),
                Divider(height: 1,),
                Text('Отделения',style: header1()),
                SizedBox(height: 25,),
                Container(
                  height: 350,// FIXME: relative sizes in project
                  child: ListView.builder(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                          return _BuildOrderWidget (data: order.places[index], selected: index);
                          },
                      itemCount: order.places.length), //places.length,),
                ),  
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ 
                ElevatedButton(onPressed: _onPressed, child: Text('push me'))
              ],
            ),
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
    return Column(children: <Widget>[Text(data.name),for(var item in data.diets ) Row(children:[Expanded(child: Text(item.name)), Text(item.count.toString())])],);
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