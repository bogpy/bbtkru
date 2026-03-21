// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyImpl _$$CompanyImplFromJson(Map<String, dynamic> json) =>
    _$CompanyImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      country: json['country'] as String,
      yearFound: (json['yearFound'] as num).toInt(),
      employeeCount: (json['employeeCount'] as num).toInt(),
      vacancies:
          (json['vacancies'] as List<dynamic>?)
              ?.map((e) => Vacancy.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      score: (json['score'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$CompanyImplToJson(_$CompanyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'yearFound': instance.yearFound,
      'employeeCount': instance.employeeCount,
      'vacancies': instance.vacancies,
      'score': instance.score,
    };

_$RequestForCompanyImpl _$$RequestForCompanyImplFromJson(
  Map<String, dynamic> json,
) => _$RequestForCompanyImpl(
  country: json['country'] as String?,
  employeeCount: (json['employeeCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$$RequestForCompanyImplToJson(
  _$RequestForCompanyImpl instance,
) => <String, dynamic>{
  'country': instance.country,
  'employeeCount': instance.employeeCount,
};
