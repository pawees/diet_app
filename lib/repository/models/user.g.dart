part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      refresh: json['count'] as String?,
      access: json['next'] as String?,
      user_id: json['previous'] as String?,
      // results: (json['results'] as List<dynamic>)
      //     .map((e) => Result.fromJson(e as Map<String, dynamic>))
      //     .toList(),
      // seoTitle: json['seo_title'] as String?,
      // seoDescription: json['seo_description'] as String?,
      // seoKeywords: json['seo_keywords'] as String?,
      // seoH1: json['seo_h1'] as String?,
      // noindex: json['noindex'] as bool?,
      // nofollow: json['nofollow'] as bool?,
      // description: json['description'] as String?,
      // filters: json['filters'] == null
      //     ? null
      //     : Filters.fromJson(json['filters'] as Map<String, dynamic>),
      // nofollowCollections: (json['nofollow_collections'] as List<dynamic>?)
      //     ?.map((e) => e as String)
      //     .toList(),
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'refresh': instance.refresh,
      'access': instance.access,
      'user_id': instance.user_id,
      // 'results': instance.results,
      // 'seo_title': instance.seoTitle,
      // 'seo_description': instance.seoDescription,
      // 'seo_keywords': instance.seoKeywords,
      // 'seo_h1': instance.seoH1,
      // 'noindex': instance.noindex,
      // 'nofollow': instance.nofollow,
      // 'description': instance.description,
      // 'filters': instance.filters,
      // 'nofollow_collections': instance.nofollowCollections,
    };
