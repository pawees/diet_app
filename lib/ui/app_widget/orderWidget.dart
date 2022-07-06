import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:game_app_training/ui/theme/main_buttons.dart';


class OrderWidget extends StatelessWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(
      builder: (context,state) {
        return Scaffold(
          appBar:AppBar(
            title: const Center(
              child: Text(
                  'Заявки',
              style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          )),),
          body: _buildScreensWidget(state),
      );
      }
    );
  }

}


class ToggleOrdersWidget extends StatefulWidget {
  const ToggleOrdersWidget({Key? key}) : super(key: key);

  @override
  State<ToggleOrdersWidget> createState() => _ToggleOrdersWidgetState();
}

class _ToggleOrdersWidgetState extends State<ToggleOrdersWidget> {
  List<bool> isSelected = [true, false];
  void _onChanged(int index){
    setState(() {
    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
      if (buttonIndex == index) {
        isSelected[buttonIndex] = true;
      } else {
        isSelected[buttonIndex] = false;
      }
        }
          });
          }
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 13, fontWeight: FontWeight.w600);
    final children = [Text('Новая заявка', style: style), Text('Исполненные заявки',style: style),];
    final width = MediaQuery.of(context).size.width * 0.9 / max(1, children.length);
    final appBloc = BlocProvider.of<AppBloc>(context);
    return Center(
            child: Container(
              decoration: BoxDecoration(color: Color.fromARGB(255, 244, 246, 249),
                  border: Border.all(color: Color.fromARGB(255, 244, 246, 249), width: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.5,vertical: 1),
                child: ToggleButtons(
                  constraints: BoxConstraints(maxWidth: width, minWidth: width, minHeight: 43, maxHeight: 44),
                  children: children,
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  onPressed: _onChanged,
                  isSelected: isSelected,
                  selectedColor: Colors.black,
                  disabledColor: Colors.black54,
                  hoverColor: Colors.grey,
                  fillColor:Color.fromARGB(255, 255, 252, 252),
                  ),
              ),
            ),
          );
    
  }
}



class NoNewOrdersWidget extends StatelessWidget {
  const NoNewOrdersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 188,
            width: double.infinity,
            decoration:
            BoxDecoration(color: Color.fromARGB(255, 242, 244, 247),
                  border: Border.all(color: Color.fromARGB(255, 242, 244, 247), width: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
              SizedBox(height: 40,),
              Container(
                width:42,
                height:52,
                child: 
                FittedBox(
                  fit:BoxFit.cover,
                  child: 
                  ImageIcon(AssetImage('assets/images/order.png'),
                  color: Color.fromARGB(255,178, 184, 191),))),
              SizedBox(height: 25,),
              Container(child: Text('Новых заявок нет',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400),),),
            ]),
          );
    
  }
}


class CreateBtnWidget extends StatelessWidget {
  const CreateBtnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    void _createEvent(){
      appBloc.add(TapCreateOrderEvent(appBloc.state.status));
    }
    return  Container(
          height: 52,
          width: double.infinity,
          child: ElevatedButton(
            style: styleBtn,
            onPressed: _createEvent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ImageIcon(AssetImage('assets/images/icon.png'),
                // ),
                Icon(
                   Icons.add,
              color: Colors.white,
              size: 24.0,
                ),
                SizedBox(width: 10),
                const Text('Создать новую заявку'),
              ],
            ),
          ),
    );
    
  }
}


class NewOrdersWidget extends StatelessWidget {
  const NewOrdersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
            height: 188,
            width: double.infinity,
            decoration:
            BoxDecoration(color: Color.fromARGB(255, 242, 244, 247),
                  border: Border.all(color: Color.fromARGB(255, 242, 244, 247), width: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
              SizedBox(height: 40,),
              Container(
                width:42,
                height:52,
                child: 
                FittedBox(
                  fit:BoxFit.cover,
                  child: 
                  ImageIcon(AssetImage('assets/images/order.png'),
                  color: Color.fromARGB(255,178, 184, 191),))),
              SizedBox(height: 25,),
              Container(child: Text('Новых заявоки есть',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400),),),
            ]),
          );
  }
}


class _isNoNewPageWidget extends StatelessWidget {
  const _isNoNewPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          ToggleOrdersWidget(),
          SizedBox(
            height: 37,
          ),
          NoNewOrdersWidget(),
         SizedBox(
            height: 32,
          ),
          CreateBtnWidget(),
        ],
    ),
    );
  }
}


class _isNewPageWidget extends StatelessWidget {
  const _isNewPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          ToggleOrdersWidget(),
          SizedBox(
            height: 37,
          ),
          CreateBtnWidget(),

          NewOrdersWidget(),
         SizedBox(
            height: 32,
          ),
        ],
    ),
    );
  }
}

   
   _buildScreensWidget( AppState state) {
      return state.status.isNewOrder ?
      _isNewPageWidget() : 
      _isNoNewPageWidget();

  }