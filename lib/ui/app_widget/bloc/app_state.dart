part of 'app_bloc.dart';

enum AppStatus { initial,profile, order, error, loading, create, next_date, selected}

extension AppStatusX on AppStatus {
  bool get isInitial => this == AppStatus.initial;
  bool get isProfile => this == AppStatus.profile;
  bool get isError => this == AppStatus.error;
  bool get isLoading => this == AppStatus.loading;
  bool get isOrder => this == AppStatus.order;
  bool get isCreate => this == AppStatus.create;
  bool get isNextDate => this == AppStatus.next_date;
  bool get isSelected => this == AppStatus.selected;


}

class AppState extends Equatable {
  const AppState({
    int? selected_id,
    this.status = AppStatus.initial,
    List<Places>? places,
    String? date,}) : places = const [Places.empty], date = date ?? '',selected_id = selected_id ?? 0 ;
  
  final int selected_id;
  final AppStatus status;
  final List<Places>? places;
  final String? date;

  @override
  List<Object?> get props => [status,places,date];

  AppState copyWith({
    AppStatus? status,
    List<Places>? places,
    String? date,
    int? selected_id,

  }) {
    return AppState(
      status: status ?? this.status,
      places: places ?? this.places,
      date: date ?? this.date,
      selected_id: selected_id ?? this.selected_id,
    );
  }
}