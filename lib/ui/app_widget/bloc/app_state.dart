part of 'app_bloc.dart';

enum AppStatus {
  initial,
  profile,
  order,
  error,
  loading,
  create,
  next_date,
  selected,
  next_page,
  pre_req_order,
  have_new_order,
  choose_agency,
  exite,
  selected_certain_order
}

extension AppStatusX on AppStatus {
  bool get isInitial => this == AppStatus.initial;
  bool get isProfile => this == AppStatus.profile;
  bool get isError => this == AppStatus.error;
  bool get isLoading => this == AppStatus.loading;
  bool get isOrder => this == AppStatus.order;
  bool get isCreate => this == AppStatus.create;
  bool get isNextDate => this == AppStatus.next_date;
  bool get isSelected => this == AppStatus.selected;
  bool get isNextPage => this == AppStatus.next_page;
  bool get isPreRequestOrder => this == AppStatus.pre_req_order;
  bool get isNewOrder => this == AppStatus.have_new_order;
  bool get ischooseAgency => this == AppStatus.choose_agency;
  bool get isExite => this == AppStatus.exite;
  bool get isSelectedCertainOrder => this == AppStatus.selected_certain_order;
}

class AppState extends Equatable {
  const AppState({
    Order? order,
    this.previous = AppStatus.initial,
    Agency? agency,
    bool? is_filled,
    int? selected_id,
    int? selected_order,
    this.status = AppStatus.initial,
    List<Places>? places,
    List<Diets>? diets,
    List<Agency>? agencies,
    Date? date,
    String? user_uid,
    List<Order>? orders,
  })  : places = places ?? const [],
        date = date ?? Date.empty,
        agency = agency ?? Agency.empty,
        selected_id = selected_id ?? 0,
        selected_order = selected_order ?? 0,
        is_filled = is_filled ?? false,
        order = order ?? null,
        diets = diets ?? const [],
        agencies = agencies ?? const [],
        user_uid = user_uid ?? '',
        orders = orders ?? const [];

  final bool is_filled;
  final int selected_id;
  final int selected_order;
  final AppStatus status;
  final AppStatus previous;
  final List<Places>? places;
  final List<Diets>? diets;
  final List<Agency> agencies;
  final Date? date;
  final Agency? agency;
  final Order? order;
  final String? user_uid;
  final List<Order>? orders;

  @override
  List<Object?> get props => [
        status,
        previous,
        places,
        diets,
        date,
        agency,
        order,
        user_uid,
        agencies,
        orders,
        selected_order
      ];

  AppState copyWith({
    AppStatus? status,
    AppStatus? previous,
    List<Places>? places,
    List<Diets>? diets,
    List<Agency>? agencies,
    Date? date,
    int? selected_id,
    int? selected_order,
    bool? is_filled,
    Agency? agency,
    Order? order,
    String? user_uid,
    List<Order>? orders,
  }) {
    return AppState(
        status: status ?? this.status,
        previous: previous ?? this.previous,
        places: places ?? this.places,
        diets: diets ?? this.diets,
        date: date ?? this.date,
        agency: agency ?? this.agency,
        selected_id: selected_id ?? this.selected_id,
        is_filled: is_filled ?? this.is_filled,
        order: order ?? this.order,
        user_uid: user_uid ?? this.user_uid,
        agencies: agencies ?? this.agencies,
        orders: orders ?? this.orders,
        selected_order: selected_order ?? this.selected_order);
  }
}
