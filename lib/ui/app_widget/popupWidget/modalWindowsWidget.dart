import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:game_app_training/repository/models/agency.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:game_app_training/ui/app_widget/orderCreateWidget.dart';
import 'package:game_app_training/ui/theme/main_buttons.dart';
import 'package:game_app_training/ui/theme/styles.dart';

class _agenciesListWidget extends StatelessWidget {
  _agenciesListWidget(
      {Key? key,
      required this.bloc,
      required this.agency,
      required this.selected})
      : super(key: key);

  final AppBloc bloc;
  final Agency agency;
  final int selected;

  @override
  Widget build(BuildContext context) {
    _get_agency() {
      bloc.add(TapAgencyChoiseEvent(selected));
    }

    return GestureDetector(
      onTap: _get_agency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            agency.name.toString(),
            style: h17_400(),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            agency.address.toString(),
            style: h13_400(),
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}

smartDialog(context, state) {
  final appBloc = BlocProvider.of<AppBloc>(context);
  SmartDialog.show(
      useAnimation: true,
      clickMaskDismiss: false,
      // onDismiss: () async {
      //   await Future.delayed(Duration(milliseconds: 10));
      //   print('object');
      //   appBloc.add(AppInitialEvent());

      // },
      builder: (_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                height: 300, //FIXME
                width: 500,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white),
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Выберите учреждение',
                            style: h20_600(),
                          )),
                          IconButton(
                              onPressed: () {
                                appBloc.add(AppInitialEvent());
                                SmartDialog.dismiss();
                              },
                              icon: const Icon(Icons.close_rounded)),
                        ],
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemBuilder: (context, index) {
                                return _agenciesListWidget(
                                    bloc: appBloc,
                                    agency: state.agencies[index],
                                    selected: index);
                              },
                              itemCount: state.agencies.length)),
                    ],
                  ),
                )),
          ],
        );
      });
}

smartSuccessDialog(context,state) {
  final appBloc = BlocProvider.of<AppBloc>(context);
  SmartDialog.show(
      useAnimation: true,
      clickMaskDismiss: false,
      builder: (_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                height: 400, //FIXME
                width: 500,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white),
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                              child: SizedBox(
                            width: 20,
                          )),
                          IconButton(
                              onPressed: () {
                                // appBloc.add(AppInitialEvent());
                                SmartDialog.dismiss();
                              },
                              icon: const Icon(Icons.close_rounded)),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      const Image(image: AssetImage('assets/images/success.png')),
                      const SizedBox(height: 24,),
                      Text('Запрос отправлен',style: h32_400()),
                      const SizedBox(height: 24,),
                      Divider(height: 1,),
                      const SizedBox(height: 24,),
                      Center(child: Text('Последнее время на редактирование заканчивается в',style: h20_400())),
                      const SizedBox(
                        height: 8,
                      ),
              Container(
                height: 50,
                width: 226,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Color(0xffF2F2F7),

                ),
                child: Center(
                  child: Text('21.05.2022' + ' - 10:00',
                      style: h20_400()),
                ),//INSERT THIS state.order.date.dd_mm_yyyy.toString() add appState to parameter this method
              ),
               const SizedBox(
                        height: 10,
                      ),

                    ],
                  ),
                )),
          ],
        );
      });
}
smartErrorDialog(context,state) {
  final appBloc = BlocProvider.of<AppBloc>(context);
  SmartDialog.show(
      useAnimation: true,
      clickMaskDismiss: false,
      builder: (_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                height: 400, //FIXME
                width: 500,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white),
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                              child: SizedBox(
                            width: 20,
                          )),
                          IconButton(
                              onPressed: () {
                         
                                SmartDialog.dismiss();
                              },
                              icon: const Icon(Icons.close_rounded)),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      const Image(image: AssetImage('assets/images/error.png')),
                      const SizedBox(height: 24,),
                      Text('Заявка не сформирована.',style: h32_400()),
                      const SizedBox(height: 24,),
                      Divider(height: 1,),
                      const SizedBox(height: 24,),
                      Center(child: Text('Нельзя обновить заказ с указанной датой исполнения.',style: h20_400())),
  
                    ],
                  ),
                )),
          ],
        );
      });

}


  
// smartChooseDataDialog(context, AppState state) {
//   final appBloc = BlocProvider.of<AppBloc>(context);
  
//   _on_pressed(){
//   appBloc.add(HaveNewOrderEvent());
//   }

//   SmartDialog.show(
//       useAnimation: true,
//       clickMaskDismiss: false,
//       builder: (_) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//                 height: 246, //FIXME
//                 width: 500,
//                 decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20)),
//                     color: Colors.white),
//                 alignment: Alignment.topCenter,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Text('Выберите дату',style: h20_600()),
//                           const Expanded(
//                               child: SizedBox(
//                             width: 20,
//                           )),
//                           IconButton(
//                               onPressed: () {
                         
//                                 SmartDialog.dismiss();
//                               },
//                               icon: const Icon(Icons.close_rounded)),
//                         ],
//                       ),
//                       const SizedBox(height: 15),
//                       _DateWidget(bloc: appBloc, date: state.date,date_counter: state.date_counter,),
//                       const SizedBox(height: 24),
//                       OrangeBtn(context, _on_pressed, 'Создать')
//                     ],
//                   ),
//                 )),
//           ],
//         );
//       });

// }


 