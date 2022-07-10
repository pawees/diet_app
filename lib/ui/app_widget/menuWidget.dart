import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/repository/models/places.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:game_app_training/ui/app_widget/headerWidget.dart';
import 'package:game_app_training/ui/theme/styles.dart';
import 'package:game_app_training/ui/theme/main_buttons.dart';

import 'package:game_app_training/repository/models/diets.dart';
import 'package:game_app_training/repository/models/order.dart';

_countBuilder(data, AppState state) {
  if (state.status.isSelected) {
    return Text(data.count.toString());
  }
}

class SummaryAndBtnWidget extends StatelessWidget {
  const SummaryAndBtnWidget({Key? key, required this.state}) : super(key: key);
  final AppState? state;

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    var place = state!.places![state!.selected_id];

    _next_place() {
      //checking for null diets count,if null drop error.

      //использовать не лист,а то,что не будет дублироваться MAP<index,Places>
      // menuNames = Diets.fetchAll();
      int len = state!.places!.length - 1;
      int cur = state!.selected_id;
      int next = cur + 1;
      appBloc.add(NextPlaceEvent(next));
    }

    ;

    _formed_order() {
      List<Places> listing = [];
      List<Places> finalListing = [];
      state!.places!
          .map((item) => {
                if (item.diets != null) {listing.add(item)}
              })
          .toList();
      //можно занести в блок этот кусок кода.

      for (final el in listing) {
        List<Diets> res = el.isFilledMenu();
        if (res != null) {
          el.diets = res;
          finalListing.add(el);
        }
      }
      ;

      //перебрать листинг,если там одни нули то выкинуть снэк бар с ошибкой.FIXME:

      Order order = Order(id: '130-re3-2', places: finalListing);
      appBloc.add(FormOrderEvent(order));
    }

    if (state!.places!.length - 1 == state!.selected_id) {
      return Column(
        children: [
          Row(
            children: [
              Text('Итого Рацион'),
              SizedBox(
                width: 50,
              ),
              Text('none') //это значение пока под вопросом.Непонятно что это.
            ],
          ),
          Container(
              height: 52, width: 152, child: formedBtn(context, _formed_order))
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              Text('Итого Рацион'),
              SizedBox(
                width: 50,
              ),
              Text('none') //это значение пока под вопросом.Непонятно что это.
            ],
          ),
          Container(
              height: 52, width: 152, child: mainBtn(context, _next_place))
        ],
      );
    }
  }
}

class _MenuWidgetRow extends StatelessWidget {
  _MenuWidgetRow(
      {Key? key,
      required this.state,
      required this.data,
      required this.selected})
      : super(key: key);
  final Diets data;
  final int selected;
  var state;

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);

    _inc() {
      //взять стэйт,селект проверить на существование(создать) прибавить
      appBloc.add(ChangeCountEvent(selected));
      data.count += 1;
    }

    ;
    _decr() {
      //убавить
      appBloc.add(ChangeCountEvent(selected));
      if (data.count == 0) return;
      data.count -= 1;
    }

    ;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.info,
                color: Colors.blue,
              ),
              SizedBox(width: 15),
              Expanded(
                  child: Text(
                data.name,
                style: header2(),
              )),
              IconButton(
                icon: Icon(Icons.plus_one),
                onPressed: _inc,
              ),
              // _countBuilder(data: data),
              _countBuilder(data, state),

              IconButton(
                icon: Icon(Icons.exposure_minus_1_outlined),
                onPressed: _decr,
              ),
            ],
          ),
          SizedBox(
            height: 28,
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}

class MenuChoiseWidget extends StatelessWidget {
  const MenuChoiseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      var place = state.places![state.selected_id];
      if (place.diets == null) {
        List<Diets> menuNames = Diets.fetchAll();
        place.diets = menuNames;
        // state.order!.places!.add(Places(id: index, name: place.name, diets: menuNames));

      }

      return Padding(
        padding: const EdgeInsets.fromLTRB(17, 5, 30, 5),
        child: Column(
          children: [
            HeaderWidget(title: place.name),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Рацион'),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    //проверить стэйт, если нет то заинитить.
                    if (index == Diets.fetchAll().length) {
                      return SummaryAndBtnWidget(state: state);
                    }
                    return _MenuWidgetRow(
                        data: place.diets![index],
                        selected: index,
                        state: state);
                  },
                  itemCount: Diets.fetchAll().length + 1),
            ),
          ],
        ),
      );
    });
  }
}
