part of 'app_bloc.dart';

enum AppStatus { initial,profile, order, error, loading, create}

extension AppStatusX on AppStatus {
  bool get isInitial => this == AppStatus.initial;
  bool get isProfile => this == AppStatus.profile;
  bool get isError => this == AppStatus.error;
  bool get isLoading => this == AppStatus.loading;
  bool get isOrder => this == AppStatus.order;
  bool get isCreate => this == AppStatus.create;
}

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.initial,
    List<String>? places,}) : places = places ?? const [];
  
  final AppStatus status;
  final List<String>? places;

  @override
  List<Object?> get props => [status,places];

  AppState copyWith({
    AppStatus? status,
    List<String>? places,
  }) {
    return AppState(
      status: status ?? this.status,
      places: places ?? this.places,
    );
  }
}