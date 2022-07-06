import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/menuWidget.dart';
import 'package:game_app_training/ui/app_widget/orderCreateWidget.dart';
import 'package:game_app_training/ui/app_widget/orderWidget.dart';
import 'package:game_app_training/ui/app_widget/preRequestWidget.dart';
import 'package:game_app_training/ui/app_widget/profileWidget.dart';



class NavigatorBar extends StatefulWidget {
  const NavigatorBar({Key? key}) : super(key: key);

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {

  final appBloc = BlocProvider.of<AppBloc>(context);

  
  void onSelected(int index){
    if (_selected == index) return;

    setState((){
    _selected = index;});
    if (_selected == 0){
      appBloc.add(AppInitialEvent());
    }
    if (_selected == 2){
      appBloc.add(TapProfileNavEvent());
    };

  }
    return BlocBuilder<AppBloc,AppState>(
      builder: (context,state) {
        return Scaffold(
          body: _buildScreensWidget(state),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/union.png'),), label:'Заявки'),
              BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/qr_code.png')), label:'QR-коод'),
              BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/profile.png')), label:'Профиль'),
            ],
            currentIndex: _selected,
            onTap: onSelected,
          ),
      );
      }
    );
  }
  
   _buildScreensWidget( AppState state) {
    if (state.status.isOrder){
      return OrderWidget();
    }
    if (state.status.isProfile){
      return ProfileWidget();
    }
    if (state.status.isCreate){
      return OrderCreateWidget(places: state.places);
    }
     if (state.status.isSelected){
      return MenuChoiseWidget();
    }
    if (state.status.isLoading){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: Center(child: CircularProgressIndicator()),),
     
        ],
      );
    }
    if (state.status.isPreRequestOrder){
      return PreRequestWidget();
    } 
    
  }
}

