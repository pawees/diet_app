import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/repository/models/date.dart';
import 'package:game_app_training/repository/models/order.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:game_app_training/ui/app_widget/headerWidget.dart';
import 'package:game_app_training/ui/theme/main_buttons.dart';
import 'package:game_app_training/ui/theme/styles.dart';

class CertainOrderWidget extends StatelessWidget {
  CertainOrderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final Order order = state.orders![state.selected_order];
        String? title = state.title;
        String order_num = order.pk.toString();
        Date? order_date = order.date;
        String? order_agency = order.agency!.name;
        String? order_address = order.agency!.address;
        // return HeaderWidget(title: 'Номер заявки № - $order_num');

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderWidget(title: '$title $order_num'),
              Text('Дата', style: header1()),
              const SizedBox(
                height: 12,
              ),
              Text(order_date!.dd_mm_yyyy.toString(), style: h20_400()),
              Text(order_date.day_of_week.toString(), style: h13_400()),
              const SizedBox(
                height: 12,
              ),
              const Divider(
                height: 1,
              ),
              const SizedBox(
                height: 12,
              ),
              Text('Последнее время на редактирование заканчивается:',
                  style: h14_400()),
              SizedBox(
                height: 8,
              ),
              Text(order_date!.dd_mm_yyyy.toString() + ' - 10:00',
                  style: h18_400()),
              Text(order_date.day_of_week.toString(), style: h13_400()),
              const SizedBox(
                height: 16,
              ),
              const Divider(
                height: 1,
              ),
              const SizedBox(
                height: 16,
              ),
              Text('Учреждение', style: header1()),
              const SizedBox(
                height: 16,
              ),
              Text(
                order_agency.toString(),
                style: h20_400(),
              ),
              Text(
                order_address.toString(),
                style: h13_400(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 1,
              ),
              const SizedBox(
                height: 16,
              ),
              Text('Отделения', style: header1()),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == order.places!.length ) {
                        return _EditAndCopyBtnsWidget(order);
                      
                    }
                    return _PlacesDietsList(
                        pl_list: order.places, index: index);
                  },
                  itemCount: order.places!.length + 1,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _EditAndCopyBtnsWidget extends StatelessWidget {
  _EditAndCopyBtnsWidget(this.order);
  final order;

  @override
  Widget build(BuildContext context) {
    _edit_order() {}
    _copy_order() {}
    if(order.isEditable){
      return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OrangeBtn(context, _edit_order, 'Редактировать'),
        const SizedBox(
          height: 16,
        ),
        GreyBtn(context, _copy_order, 'Копировать данные'),
        const SizedBox(
          height: 4,
        ),
      ],
    );
    }else{
      return 
      Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GreyBtn(context, _copy_order, 'Копировать данные'),
        const SizedBox(
          height: 30,
        ),
      ],
    );
    }
    
  }
}

class _PlacesDietsList extends StatelessWidget {
  _PlacesDietsList({Key? key, this.pl_list, this.index}) : super(key: key);
  List? pl_list;
  var index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(pl_list![index].name, style: h18_500()),
        const SizedBox(height: 24),
        for (var item in pl_list![index].diets)
          Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Row(children: [
                Expanded(
                    child: Text(
                  item.name,
                  style: header2(),
                )),
                Text(item.count.toString(), style: h18_500())
              ]),
            ],
          ),
        const SizedBox(
          height: 24,
        ),
        const Divider(
          height: 1,
        ),
        const SizedBox(
          height: 24,
        )
      ],
    );
  }
}
