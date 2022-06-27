import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';


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

class NoNewOrderWidget extends StatefulWidget {
  const NoNewOrderWidget({Key? key}) : super(key: key);

  @override
  State<NoNewOrderWidget> createState() => _NoNewOrderWidgetState();
}


class _NoNewOrderWidgetState extends State<NoNewOrderWidget> {
  
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(color: Color.fromARGB(195, 206, 206, 206),
                  border: Border.all(color: Color.fromARGB(195, 206, 206, 206), width: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),),
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
          )

      ],),
    );
    
  }
}

class _NewOrderWidgetState extends State<NoNewOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),

      ],),
    );
    
  }
}

   _buildScreensWidget( AppState state) {
      return NoNewOrderWidget();

    // if (state.status.isOrder){
    //   return NoNewOrderWidget();
    // }
    // if (state.status.isProfile){
    //   return NewOrderWidget();
    // }
    
  }