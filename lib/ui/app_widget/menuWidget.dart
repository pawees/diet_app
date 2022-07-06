import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/repository/models/places.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:game_app_training/ui/theme/styles.dart';
import 'package:game_app_training/ui/theme/main_buttons.dart';

import 'package:game_app_training/repository/models/diets.dart';
import 'package:game_app_training/repository/models/order.dart';




List<Places> listPlaces = [];


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
      int len = state!.places!.length - 1;
      int cur = state!.selected_id;
      int next = cur + 1;
      appBloc.add(NextPlaceEvent(next));
      // collect order data,probably_clean model,opened next page///
      // Place(id:id_place,diets,)
      // Place(add to state)
      // Next screen.give true status if common count !=0.
      // Render Ok check(if status:true => render)
    };
    _formed_order(){

      Order order = Order(id:'130-re3-2', places: listPlaces);
      appBloc.add(FormOrderEvent(order));
      //create event sendOrderRequest -> send_req -> save in hive.
      //new screen display



      // check,that last item index,and add event to formed order.
      // all data keep state.
      //formed order page. ^)mean render data from state then save it all in Hive and formed Json

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

    _on_pressed(){};
    
    return BlocBuilder<AppBloc,AppState>(
      builder: (context,state) {
        var place = state.places![state.selected_id];
        return Scaffold(
          appBar:AppBar(
            title: Center(
              child: Text(
                  place.name,
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
                  height: 485,
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
           ] ),
          ),
      );
      }
    );
  }

}