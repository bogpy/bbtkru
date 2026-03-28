// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applicant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplicantImpl _$$ApplicantImplFromJson(Map<String, dynamic> json) =>
    _$ApplicantImpl(
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

Map<String, dynamic> _$$ApplicantImplToJson(_$ApplicantImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
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

_$RequestForApplicantImpl _$$RequestForApplicantImplFromJson(
  Map<String, dynamic> json,
) => _$RequestForApplicantImpl(
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

Map<String, dynamic> _$$RequestForApplicantImplToJson(
  _$RequestForApplicantImpl instance,
) => <String, dynamic>{
  if (instance.experience case final value?) 'experience': value,
  if (_$LevelTypeEnumMap[instance.level] case final value?) 'level': value,
  if (instance.graduated case final value?) 'graduated': value,
  if (_$EducationTypeEnumMap[instance.education] case final value?)
    'education': value,
  if (_$SpecialtyTypeEnumMap[instance.specialty] case final value?)
    'specialty': value,
  'languagesRequired': instance.languagesRequired,
  'languagesOptional': instance.languagesOptional,
  'technologiesRequired': instance.technologiesRequired,
  'technologiesOptional': instance.technologiesOptional,
};
