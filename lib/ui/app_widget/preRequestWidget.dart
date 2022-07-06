import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:game_app_training/ui/app_widget/orderCreateWidget.dart';
import 'package:game_app_training/ui/theme/styles.dart';

class PreRequestWidget extends StatelessWidget {
  const PreRequestWidget({Key? key}) : super(key: key);

//from hive insert data
  
  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    _onPressed(){
      appBloc.add(HaveNewOrderEvent());

    }
    return SafeArea(
      child: Column(
        children: [
                  Row(children: [
            IconButton(
                icon: ImageIcon(AssetImage('assets/images/chevron.png')),
                onPressed: (){}),
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
            // _build_data_widget(call hive order); 
            //Divider(height: 1,),
                SizedBox(height: 16,),

                Text('Учреждение',style: header1()),
                SizedBox(height: 16,),
                Agency(title: 'ДДЦ Центр здоровья для детей', address:'610027,Кировская область,г.Киров,ул Красноармейская,43'),
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
                          return Text('abc');//PlacesWidget(data: places[index], selected: index);
                          },
                      itemCount: 10), //places.length,),
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