import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Game {
  const Game({
    this.refresh,
    this.access,
    this.user_id,
    // required this.results,
    // this.seoTitle,
    // this.seoDescription,
    // this.seoKeywords,
    // this.seoH1,
    // this.noindex,
    // this.nofollow,
    // this.description,
    // this.filters,
    // this.nofollowCollections,
  });

  final String? refresh;
  final String? access;
  // final int? previous;
  // final List<Result> results;
  final String? user_id;
  // final String? seoDescription;
  // final String? seoKeywords;
  // final String? seoH1;
  // final bool? noindex;
  // final bool? nofollow;
  // final String? description;
  // final Filters? filters;
  // final List<String>? nofollowCollections;

  // static const empty = Game(
  //   count: 0,
  //   next: '',
  //   previous: 0,
  //   results: [],
  //   seoTitle: '',
  //   seoDescription: '',
  //   seoKeywords: '',
  //   seoH1: '',
  //   noindex: false,
  //   nofollow: false,
  //   description: '',
  //   filters: Filters(years: []),
  //   nofollowCollections: [],
  // );

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}
