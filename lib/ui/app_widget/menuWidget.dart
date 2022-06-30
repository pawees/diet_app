import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:game_app_training/ui/theme/styles.dart';

List<MenuRowData> menuNames = [
  MenuRowData('ОВД'),
  MenuRowData('Зонд'),
  MenuRowData('ОВД2'),
  MenuRowData('ЩД'),
  MenuRowData('НКД'),
  MenuRowData('ОВДм'),
  MenuRowData('ОВД'),
  MenuRowData('ЩД1'),
  MenuRowData('ОВдр'),
  MenuRowData('ЩДб/м'),
  MenuRowData('Х1'),
  MenuRowData('ВБД1'),]; //FIXME: create model

class MenuRowData {
  final String text;

  MenuRowData(this.text);
}

class _MenuRowWidget extends StatelessWidget {
  final List<MenuRowData> menuRow;
  const _MenuRowWidget({Key? key,required this.menuRow,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: menuRow.map((data) => _MenuWidgetRow(data: data)).toList(),
    );
    
  }
}



class _MenuWidgetRow extends StatelessWidget {
  const _MenuWidgetRow({Key? key,
  required this.data}) : super(key: key);
  final MenuRowData data;
  
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
              Expanded(child: Text(data.text,style: header2(),)),
              Icon(Icons.plus_one),
              Icon(Icons.plus_one),
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
    final styleBtn = ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.orange),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        textStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.0),
        )));
    return BlocBuilder<AppBloc,AppState>(
      builder: (context,state) {
        return Scaffold(
          appBar:AppBar(
            title: const Center(
              child: Text(
                  'Терапия(взрослое)',//FIXME:hardcode
              style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          )),),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(17, 5, 30, 5),
            child: ListView(
              children: [Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                 SizedBox(height: 25,),
                 Text('Рацион',style: header1(),),
                 SizedBox(height: 28,),
                 Container(
                  height: 305,
                   child: _MenuRowWidget(menuRow: menuNames),
                 ),
                 Expanded(child: Text('Итого рацион',style: header1(),)),
                 Text('6'),
                 Container(
                      height: 52,
                      width: double.infinity,
                      child: ElevatedButton(
              style: styleBtn,
              onPressed: (){},
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
                  const Text('Готово'),
                ],
              ),
                      ),)
            
            
                ],
              ),
           ] ),
          ),
      );
      }
    );
  }

}