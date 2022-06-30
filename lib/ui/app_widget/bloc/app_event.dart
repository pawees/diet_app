part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}
class AppInitialEvent extends AppEvent {}
class TapOrderNavEvent extends AppEvent {}
class TapProfileNavEvent extends AppEvent {}
class TapCreateOrderEvent extends AppEvent {}
class TapNextDateEvent extends AppEvent {
  int count;
  TapNextDateEvent(this.count);
}
class GetMenuEvent extends AppEvent{}
