import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:game_app_training/ui/theme/styles.dart';
import 'package:game_app_training/ui/theme/main_buttons.dart';

import 'package:game_app_training/repository/models/diets.dart';


List<Diets> menuNames = [
  Diets(name: 'ОВД', count: 0),
  Diets(name:'Зонд',count:0),
  Diets(name:'ОВД2',count:0),
  Diets(name:'ЩД',count:0),
  Diets(name:'НКД',count:0),
  Diets(name:'ОВДм',count:0),
  Diets(name:'ОВД',count:0),
  Diets(name:'ЩД1',count:0),
  Diets(name:'ОВдр',count:0),
  Diets(name:'ЩДб/м',count:0),
  Diets(name:'Х1',count:0),
  Diets(name:'ВБД1',count:0),
  ]; 



// class _MenuRowWidget extends StatelessWidget {
//   final List<Diets> menuRow;
//   const _MenuRowWidget({Key? key,required this.menuRow,}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: menuRow.map((data) => _MenuWidgetRow(data: data)).toList(),
//     );
    
//   }
// }

class _countBuilder extends StatelessWidget {
  const _countBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('0');
    
  }
}

class _MenuWidgetRow extends StatelessWidget {
  const _MenuWidgetRow({
    Key? key,
    required this.data,
    required this.selected}) : super(key: key);
  final Diets data;
  final int selected;
  
   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(Icons.info,color: Colors.blue,),
              SizedBox(width: 15),
              Expanded(child: Text(data.name, style: header2(),)),
              IconButton(icon: Icon(Icons.countertops), onPressed: (){print(selected);},),
              _countBuilder(),
              IconButton(icon: Icon(Icons.plus_one), onPressed: (){print(selected);},),

            ],
          ),
          SizedBox(height: 28,),
          Divider(height: 1,),
        ],
      ),
    );
  }
}


class MenuChoiseWidget extends StatelessWidget {
  const MenuChoiseWidget({Key? key}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    _on_pressed(){};
    
    return BlocBuilder<AppBloc,AppState>(
      builder: (context,state) {
        var ioi = state.places![state.selected_id];
        return Scaffold(
          appBar:AppBar(
            title: Center(
              child: Text(
                  ioi.name,
              style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          )),),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(17, 5, 30, 5),
            child: ListView(
              children: [Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                 SizedBox(height: 25,),
                 Text('Рацион', style: header1(),),
                 SizedBox(height: 28,),
                 Container(
                  height: 455,
                   child: ListView.builder(
                    // child: _MenuRowWidget(menuRow: menuNames),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                          return _MenuWidgetRow(data: menuNames[index], selected: index);
                          },
                    itemCount: menuNames.length
                    ),
                 ),
                //  Expanded(child: Text('Итого рацион',style: header1(),)),
                //  Text('6'),
                //  Container(
                //       height: 52,
                //       width: double.infinity,
                //       child: mainBtn(context, _on_pressed) )
            
            
                ],
              ),
           ] ),
          ),
      );
      }
    );
  }

}