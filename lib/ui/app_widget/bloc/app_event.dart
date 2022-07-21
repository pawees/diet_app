part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppInitialEvent extends AppEvent {}

class TapOrderNavEvent extends AppEvent {}

class TapProfileNavEvent extends AppEvent {}

class TapCreateOrderEvent extends AppEvent {
  AppStatus? prev_status;
  TapCreateOrderEvent(this.prev_status);
}

class TapNextDateEvent extends AppEvent {
  TapNextDateEvent(this.increment);
  bool increment;
}

class GetMenuEvent extends AppEvent {
  int id;
  GetMenuEvent(this.id);
}

class ChangeCountEvent extends AppEvent {
  int id;
  ChangeCountEvent(this.id);
}

class NextPlaceEvent extends AppEvent {
  int? id;
  NextPlaceEvent(this.id);
}

class FormOrderEvent extends AppEvent {
  Order order;
  FormOrderEvent(this.order);
}

class HaveNewOrderEvent extends AppEvent {
  String date;
  HaveNewOrderEvent(this.date);
}

class PreviousScreenEvent extends AppEvent {}

class TapAgencyChoiseEvent extends AppEvent {
  int id;
  TapAgencyChoiseEvent(this.id);
}

class GetCertainOrderEvent extends AppEvent {
  int id;
  GetCertainOrderEvent(this.id);
}

class EditOrderEvent extends AppEvent {
  int id;
  EditOrderEvent(this.id);
}
class CopyAndCreateEvent extends AppEvent {}