// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacancy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VacancyImpl _$$VacancyImplFromJson(Map<String, dynamic> json) =>
    _$VacancyImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      companyID: (json['companyID'] as num).toInt(),
      companyName: json['companyName'] as String,
      experience: (json['experience'] as num).toInt(),
      salary: (json['salary'] as num).toInt(),
      hours: (json['hours'] as num).toInt(),
      employment: $enumDecode(_$EmploymentTypeEnumMap, json['employment']),
      location: $enumDecode(_$LocationTypeEnumMap, json['location']),
      languages:
          (json['languages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      technologies:
          (json['technologies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      score: (json['score'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$VacancyImplToJson(_$VacancyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'companyID': instance.companyID,
      'companyName': instance.companyName,
      'experience': instance.experience,
      'salary': instance.salary,
      'hours': instance.hours,
      'employment': _$EmploymentTypeEnumMap[instance.employment]!,
      'location': _$LocationTypeEnumMap[instance.location]!,
      'languages': instance.languages,
      'technologies': instance.technologies,
      'score': instance.score,
    };

const _$EmploymentTypeEnumMap = {
  EmploymentType.internship: 'Internship',
  EmploymentType.fullTime: 'Full-time',
  EmploymentType.partTime: 'Part-time',
};

const _$LocationTypeEnumMap = {
  LocationType.remote: 'Remote',
  LocationType.hybrid: 'Hybrid',
  LocationType.inOffice: 'In-office',
};

_$RequestForVacancyImpl _$$RequestForVacancyImplFromJson(
  Map<String, dynamic> json,
) => _$RequestForVacancyImpl(
  experience: (json['experience'] as num?)?.toInt(),
  salary: (json['salary'] as num?)?.toInt(),
  employment: $enumDecodeNullable(_$EmploymentTypeEnumMap, json['employment']),
  location: $enumDecodeNullable(_$LocationTypeEnumMap, json['location']),
  country: json['country'] as String?,
  hours: (json['hours'] as num?)?.toInt(),
);

Map<String, dynamic> _$$RequestForVacancyImplToJson(
  _$RequestForVacancyImpl instance,
) => <String, dynamic>{
  if (instance.experience case final value?) 'experience': value,
  if (instance.salary case final value?) 'salary': value,
  if (_$EmploymentTypeEnumMap[instance.employment] case final value?)
    'employment': value,
  if (_$LocationTypeEnumMap[instance.location] case final value?)
    'location': value,
  if (instance.country case final value?) 'country': value,
  if (instance.hours case final value?) 'hours': value,
};
