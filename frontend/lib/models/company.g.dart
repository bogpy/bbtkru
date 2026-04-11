// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Company _$CompanyFromJson(Map<String, dynamic> json) => _Company(
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

Map<String, dynamic> _$CompanyToJson(_Company instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'country': instance.country,
  'yearFound': instance.yearFound,
  'employeeCount': instance.employeeCount,
  'vacancies': instance.vacancies.map((e) => e.toJson()).toList(),
  'score': instance.score,
};

_RequestForCompany _$RequestForCompanyFromJson(Map<String, dynamic> json) =>
    _RequestForCompany(
      country: json['country'] as String?,
      employeeCount: (json['employeeCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RequestForCompanyToJson(_RequestForCompany instance) =>
    <String, dynamic>{
      'country': ?instance.country,
      'employeeCount': ?instance.employeeCount,
    };
