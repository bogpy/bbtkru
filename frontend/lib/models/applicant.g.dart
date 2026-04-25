// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applicant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Applicant _$ApplicantFromJson(Map<String, dynamic> json) => _Applicant(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
  education: $enumDecode(_$EducationTypeEnumMap, json['education']),
  university: json['university'] as String,
  graduated: json['graduated'] as bool,
  specialty: $enumDecode(_$SpecialtyTypeEnumMap, json['specialty']),
  level: $enumDecode(_$LevelTypeEnumMap, json['level']),
  experience: (json['experience'] as num).toInt(),
  workHistory: json['workHistory'] as String? ?? "",
  languages:
      (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  technologies:
      (json['technologies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  score: (json['score'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ApplicantToJson(_Applicant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dateOfBirth': _dateTimeToJson(instance.dateOfBirth),
      'education': _$EducationTypeEnumMap[instance.education]!,
      'university': instance.university,
      'graduated': instance.graduated,
      'specialty': _$SpecialtyTypeEnumMap[instance.specialty]!,
      'level': _$LevelTypeEnumMap[instance.level]!,
      'experience': instance.experience,
      'workHistory': instance.workHistory,
      'languages': instance.languages,
      'technologies': instance.technologies,
      'score': instance.score,
    };

const _$EducationTypeEnumMap = {
  EducationType.highSchool: 'HighSchool',
  EducationType.bachelor: 'Bachelor',
  EducationType.master: 'Master',
  EducationType.phD: 'PhD',
};

const _$SpecialtyTypeEnumMap = {
  SpecialtyType.frontend: 'Frontend',
  SpecialtyType.backend: 'Backend',
  SpecialtyType.fullstack: 'Fullstack',
  SpecialtyType.dataEngineer: 'DataEngineer',
  SpecialtyType.devOps: 'DevOps',
};

const _$LevelTypeEnumMap = {
  LevelType.intern: 'Intern',
  LevelType.junior: 'Junior',
  LevelType.middle: 'Middle',
  LevelType.senior: 'Senior',
  LevelType.lead: 'Lead',
};

_PublicationRequestForApplicant _$PublicationRequestForApplicantFromJson(
  Map<String, dynamic> json,
) => _PublicationRequestForApplicant(
  name: json['name'] as String,
  dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
  education: $enumDecode(_$EducationTypeEnumMap, json['education']),
  university: json['university'] as String,
  graduated: json['graduated'] as bool,
  specialty: $enumDecode(_$SpecialtyTypeEnumMap, json['specialty']),
  level: $enumDecode(_$LevelTypeEnumMap, json['level']),
  experience: (json['experience'] as num).toInt(),
  workHistory: json['workHistory'] as String? ?? "",
  languages:
      (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  technologies:
      (json['technologies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$PublicationRequestForApplicantToJson(
  _PublicationRequestForApplicant instance,
) => <String, dynamic>{
  'name': instance.name,
  'dateOfBirth': _dateTimeToJson(instance.dateOfBirth),
  'education': _$EducationTypeEnumMap[instance.education]!,
  'university': instance.university,
  'graduated': instance.graduated,
  'specialty': _$SpecialtyTypeEnumMap[instance.specialty]!,
  'level': _$LevelTypeEnumMap[instance.level]!,
  'experience': instance.experience,
  'workHistory': instance.workHistory,
  'languages': instance.languages,
  'technologies': instance.technologies,
};

_RequestForApplicant _$RequestForApplicantFromJson(Map<String, dynamic> json) =>
    _RequestForApplicant(
      name: json['name'] as String?,
      experience: (json['experience'] as num?)?.toInt(),
      level: $enumDecodeNullable(_$LevelTypeEnumMap, json['level']),
      graduated: json['graduated'] as bool?,
      education: $enumDecodeNullable(_$EducationTypeEnumMap, json['education']),
      specialty: $enumDecodeNullable(_$SpecialtyTypeEnumMap, json['specialty']),
      languagesRequired:
          (json['languagesRequired'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      languagesOptional:
          (json['languagesOptional'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      technologiesRequired:
          (json['technologiesRequired'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      technologiesOptional:
          (json['technologiesOptional'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RequestForApplicantToJson(
  _RequestForApplicant instance,
) => <String, dynamic>{
  'name': ?instance.name,
  'experience': ?instance.experience,
  'level': ?_$LevelTypeEnumMap[instance.level],
  'graduated': ?instance.graduated,
  'education': ?_$EducationTypeEnumMap[instance.education],
  'specialty': ?_$SpecialtyTypeEnumMap[instance.specialty],
  'languagesRequired': ?_listToQuery(instance.languagesRequired),
  'languagesOptional': ?_listToQuery(instance.languagesOptional),
  'technologiesRequired': ?_listToQuery(instance.technologiesRequired),
  'technologiesOptional': ?_listToQuery(instance.technologiesOptional),
};
