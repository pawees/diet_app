class Date {
  final String? dd_mm_yyyy;
  final String? day_of_week;
  final String? date_for_request;

  const Date({this.dd_mm_yyyy, this.day_of_week, this.date_for_request});

  static const empty = Date(
    dd_mm_yyyy: '',
    day_of_week: '',
    date_for_request: '',
  );
}
