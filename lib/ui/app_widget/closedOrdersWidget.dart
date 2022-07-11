import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:game_app_training/ui/app_widget/headerWidget.dart';
import 'package:game_app_training/ui/theme/styles.dart';

class ClosedOrdersWidget extends StatelessWidget {
  const ClosedOrdersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const SizedBox(height: 32,),
        const Divider(height:1),
        const SizedBox(height: 32,),
        Container(
                height: 165,
                width: double.infinity,
                decoration:
                BoxDecoration(color: Color.fromARGB(185, 185, 211, 243),
                      border: Border.all(color: Color.fromARGB(255, 147, 175, 207), width: 1.0),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10) ,topRight:Radius.circular(10) ),
                      
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Expanded(child: Text('Номер заявки',style: h20_400(),)),
                        Text('№-35677',style:header1())
                      ],
                    ),
                    SizedBox(height: 12,),
                    Divider(height: 1,),
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        Expanded(child: Text('Последнее время на редактирование заканчивается:',style: h14_400())),
                           IconButton(
    // iconSize: 16.3,
    // padding: const EdgeInsets.symmetric(horizontal:0.0),
    // alignment: Alignment.centerLeft,
    icon: ImageIcon(AssetImage('assets/images/changeAgency.png'),color: Color.fromARGB(255, 64, 105, 153),),
    onPressed: (){
      //FIXME update order btn
      //Make active

    }),


                        
                      ],
                    ),
                    SizedBox(height: 12),
                    //FIXME jiffy time!
                    Text('22.05.2022 - 10:00',style: h18_500()),
                    SizedBox(height: 16),




                  ]),
                ),
              ),
                           Container(
                      width: double.infinity,
                      height: 230,
                      decoration:BoxDecoration(
                        border:Border.all(color: Color.fromARGB(255, 147, 175, 207), width: 1.0),
                        borderRadius:BorderRadius.only(bottomLeft: Radius.circular(10) ,bottomRight:Radius.circular(10) ),
                         ),
                      
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          SizedBox(height: 12,),
                          Text('Дата',style: h14_400()),
                          Text('22.05.2022',style: h18_500()),
                          SizedBox(height: 12,),
                          Divider(height: 1,),
                          SizedBox(height: 12,),
                          Text('Учреждение',style: h14_400()),
                          Text('Учреждение имени Кировa № 8',style:h18_500()), //FIXME  hardode
                          Text('610027,Киров,Кировская область,Красноармейская 101б',style:h13_400()),
                          SizedBox(height: 16,),
                          Divider(height: 1,),
                          SizedBox(height: 12,),
                          Text('Пациентов'),
                          SizedBox(height: 5,),
                          Text('10',style:h18_500()),
                          SizedBox(height: 16,),

                           //FIXME  hardode
                           //FIXME yewllow header(for time)



                          


                        ],),
                      ),)       
      ],
    );
  }
}