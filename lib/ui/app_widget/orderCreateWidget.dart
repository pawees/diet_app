import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app_training/repository/models/date.dart';
import 'package:game_app_training/repository/models/diets.dart';
import 'package:game_app_training/repository/models/order.dart';
import 'package:game_app_training/ui/app_widget/bloc/app_bloc.dart';
import 'package:game_app_training/ui/app_widget/headerWidget.dart';
import 'package:game_app_training/ui/theme/main_buttons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:game_app_training/ui/theme/styles.dart';
import 'package:game_app_training/repository/models/places.dart';

class OrderCreateWidget extends StatelessWidget {
   OrderCreateWidget({
    Key? key,
    required this.places,
        count = 0,
  }) : super(key: key);

  final places;
   int   count = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    _onPressed() {
      appBloc.add(HaveNewOrderEvent());
    }
      return Padding(
        padding: const EdgeInsets.fromLTRB(17, 5, 30, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeaderWidget(title: state.title.toString()),
            Text('Дата', style: header1()),
            const SizedBox(
              height: 12,
            ),
            _buildDateWidget(state,count),
            // DateWidget(date: state.date!),
            const SizedBox(
              height: 21,
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
            _Agency(title: state.agency!.name, address: state.agency!.address),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 1,
            ),
            SizedBox(
              height: 20,
            ),
            Text('Отделения', style: header1()),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index == places.length && state.places![index].isFilled) {
                   return OrangeBtn(context, _onPressed, 'Сформировать заявку');
                  }

                  return PlacesWidget(data: places[index], selected: index);
                },
                itemCount: places.length,
              ),
            ),
            _builder_form_btn(state, state.selected_id),
          ],
        ),
      );
    });
  }
}

_builder_form_btn(state, selected) {
  if (state.edited && state.places![selected].isFilled ){
    return _EditBtnWidget();
  }
  if (state.places![selected].isFilled) {
    return _BtnWidget();  
  } else {
    return _NoBtnWidget();
  }
}
class _EditBtnWidget extends StatelessWidget {
  const _EditBtnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    _onPressed() {
      List<Places> listing = [];
      List<Places> finalListing = [];
      
      appBloc.state.places!
          .map((item) => {
                if (item.diets != null) {listing.add(item)}
              })
          .toList();
      //можно занести в блок этот кусок кода.

      for (final el in listing) {
        List<Diets> res = el.isFilledMenu();
        if (res.length != 0) {
          el.diets = res;
          finalListing.add(el);
        }
      }

      
      var user_uid = appBloc.state.user_uid;
      var date = appBloc.state.date;
      var agency = appBloc.state.agency!.uid_1c;
      
      
      Order order = appBloc.state.order!;
      order.places = finalListing;
      order.date = date;

      appBloc.add(FormOrderEvent(order));
    }
      return GreenBtn(context, _onPressed, 'Редактировать заявку');
  }
}
class _BtnWidget extends StatelessWidget {
  const _BtnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    _onPressed() {
      appBloc.add(HaveNewOrderEvent());
    }
      return OrangeBtn(context, _onPressed, 'Сформировать заявку');

  }
}

class _NoBtnWidget extends StatelessWidget {
  const _NoBtnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PlacesWidget extends StatelessWidget {
  const PlacesWidget({Key? key, required this.data, required this.selected})
      : super(key: key);
  final data;
  final int selected;

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);

    _get_menu() {
      appBloc.add(GetMenuEvent(selected)); //probaly need some id.
    }

    return GestureDetector(
      onTap: _get_menu,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 12.5,
          ),
          _builderFilledPlace(data, appBloc, selected),
          const SizedBox(
            height: 12.5,
          ),
          const Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}

_builderFilledPlace(data, appBloc, selected) {
  return appBloc.state.places![selected].isFilled
      ? FilledWidget(data: data)
      : UnfilledWidget(data: data);
}

class FilledWidget extends StatelessWidget {
  const FilledWidget({Key? key, this.data}) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIcon(AssetImage('assets/images/filledIcon.png')),
        SizedBox(
          width: 10,
        ),
        Expanded(child: Text(data.name)),
        SizedBox.fromSize(
            size: const Size.fromRadius(13),
            child: const FittedBox(child: Icon(Icons.chevron_right_sharp)))
      ],
    );
  }
}

class UnfilledWidget extends StatelessWidget {
  const UnfilledWidget({Key? key, this.data}) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(data.name)),
        SizedBox.fromSize(
            size: const Size.fromRadius(13),
            child: const FittedBox(child: Icon(Icons.chevron_right_sharp)))
      ],
    );
  }
}

class _Agency extends StatelessWidget {
  const _Agency({Key? key, this.title, this.address}) : super(key: key);

  final title;
  final address;

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    void _createEvent() {
      appBloc.add(TapCreateOrderEvent(appBloc.state.status));
    }
    return Row(
      children: [
        const ImageIcon(
          AssetImage('assets/images/filledIcon.png'),
          color: Colors.blue,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                  width: 250,
                  child: Text(
                    address,
                    style: h13_400(),
                  )),
            ],
          ),
        ),
        IconButton(
            // iconSize: 16.3,
            // padding: const EdgeInsets.symmetric(horizontal:0.0),
            // alignment: Alignment.centerLeft,
            icon: const ImageIcon(
              AssetImage('assets/images/changeAgency.png'),
              color: Color.fromARGB(255, 64, 105, 153),
            ),
            onPressed: _createEvent),
      ],
    );
  }
}

class DateWidget extends StatelessWidget {
  DateWidget({
    Key? key,
    required this.state,

  }) : super(key: key);

  final AppState state;
  
  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);

    _next() {
      appBloc.add(TapNextDateEvent());
    }

    _prev() {
      if (state.date_counter == 0) return;
      appBloc.add(TapNextDateEvent());
    }

    return Row(
      children: [
        IconButton(onPressed: _prev, icon: const Icon(Icons.chevron_left_sharp)),
        Expanded(
            child: Column(
          children: [
            Text(state.date!.dd_mm_yyyy.toString(), style: h20_400()),
            Text(
              state.date!.day_of_week.toString(),
              style: h13_400(),
            ),
          ],
        )),
        IconButton(onPressed: _next, icon: const Icon(Icons.chevron_right_sharp)),
      ],
    );
  }
}

_buildDateWidget(AppState state,int count) {
  if (state.status.isCreate) {
    return DateWidget(state: state);
  }
}
