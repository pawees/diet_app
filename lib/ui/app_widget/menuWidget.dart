import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/repository/models/places.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:game_app_training/ui/app_widget/headerWidget.dart';
import 'package:game_app_training/ui/theme/styles.dart';
import 'package:game_app_training/ui/theme/main_buttons.dart';

import 'package:game_app_training/repository/models/diets.dart';
import 'package:game_app_training/repository/models/order.dart';




List<Places> listPlaces = [];


List<Diets> menuNames = Diets.fetchAll(); 



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

// class _countBuilder extends StatelessWidget {
//   const _countBuilder({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text('0');
    
//   }
// }
 _countBuilder(data, AppState state) {
  
  if (state.status.isSelected){return Text(data.count.toString());}
 
    }
//   class _countBuilder extends StatelessWidget {
//   _countBuilder({Key? key,required this.data}) : super(key: key);
//   Diets data;
  

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AppBloc,AppState>(
//       builder: (context,state) {
//          if (state.status.isSelected) {
//           return Text(data.count.toString());
//         } else {
//           return const SizedBox();
      

//       }});
    
//   }
// }
//
  
class SummaryAndBtnWidget extends StatelessWidget {
  const SummaryAndBtnWidget({Key? key, required this.state}) : super(key: key);
  final AppState? state;

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);

    _next_place(){
      //checking for null diets count,if null drop error.
      listPlaces.add(Places(id: '1', name: 'ok', diets: menuNames));//id-name - hardcode
      menuNames = Diets.fetchAll();
      int len = state!.places!.length - 1;
      int cur = state!.selected_id;
      int next = cur + 1;
      appBloc.add(NextPlaceEvent(next));
    };

    _formed_order(){
      //check list count not null
       listPlaces.add(Places(id: '1', name: 'ok', diets: menuNames));//id-name - hardcode
      menuNames = Diets.fetchAll(); 
      Order order = Order(id:'130-re3-2', places: listPlaces);
      appBloc.add(FormOrderEvent(order));
    }
    
    if (state!.places!.length - 1 == state!.selected_id) {
      return Column(
      children: [
        Row(
          children: [
            Text('Итого Рацион'),
            SizedBox(width: 50,), 
            Text('none') //это значение пока под вопросом.Непонятно что это.
            ],
            ),
        Container(
              height: 52,
              width: 152,
              child: formedBtn(context, _formed_order) )
            ],
            );

    }else{
      return Column(
      children: [
        Row(
          children: [
            Text('Итого Рацион'),
            SizedBox(width: 50,), 
            Text('none') //это значение пока под вопросом.Непонятно что это.
            ],
            ),
        Container(
              height: 52,
              width: 152,
              child: mainBtn(context, _next_place) 
              )
            ],
            );
            }
    
  }
}


class _MenuWidgetRow extends StatelessWidget {
   _MenuWidgetRow({
    Key? key,
    required this.state,
    required this.data,
    required this.selected}) : super(key: key);
  final Diets data;
  final int selected;
  var state;
  
   @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);

    _inc(){
      appBloc.add(ChangeCountEvent(selected));

      data.count+=1;

    };
    _decr(){
      appBloc.add(ChangeCountEvent(selected));
      if (data.count == 0) return;
      data.count-=1;

    };
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
              IconButton(icon: Icon(Icons.plus_one), onPressed: _inc,),
              // _countBuilder(data: data),
              _countBuilder(data,state),

              IconButton(icon: Icon(Icons.exposure_minus_1_outlined), onPressed: _decr,),

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
    return BlocBuilder<AppBloc,AppState>(
      builder: (context,state) {
        var place = state.places![state.selected_id];
        return  Padding(
            padding: const EdgeInsets.fromLTRB(17, 5, 30, 5),
            child: Column(
              children: [
                HeaderWidget(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Рацион'),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                   // child: _MenuRowWidget(menuRow: menuNames),
                   shrinkWrap: true,
                   itemBuilder: (context, index) {
                         if(index == menuNames.length){
                
                           return SummaryAndBtnWidget(state: state);
                         }
                         return _MenuWidgetRow(data: menuNames[index], selected: index, state: state);
                         },
                   itemCount: menuNames.length + 1
                   ),
                ),
              ],
            ),
          );
      }
    );
  }

}