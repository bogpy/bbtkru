import 'package:freezed_annotation/freezed_annotation.dart';

part 'applicant.freezed.dart';
part 'applicant.g.dart';

enum EducationType {
  @JsonValue("HighSchool") highSchool,
  @JsonValue("Bachelor") bachelor,
  @JsonValue("Master") master,
  @JsonValue("PhD") phD;

  String get displayName {
    switch (this) {
      case EducationType.highSchool: return 'High School';
      case EducationType.bachelor: return 'Bachelor';
      case EducationType.master: return 'Master';
      case EducationType.phD: return 'PhD';
    }
  }
}

enum SpecialtyType {
  @JsonValue("Frontend") frontend,
  @JsonValue("Backend") backend,
  @JsonValue("Fullstack") fullstack,
  @JsonValue("DataEngineer") dataEngineer,
  @JsonValue("DevOps") devOps;

  String get displayName {
    switch (this) {
      case SpecialtyType.frontend: return 'Frontend';
      case SpecialtyType.backend: return 'Backend';
      case SpecialtyType.fullstack: return 'Fullstack';
      case SpecialtyType.dataEngineer: return 'Data Engineer';
      case SpecialtyType.devOps: return 'DevOps';
    }
  }
}

enum LevelType {
  @JsonValue("Intern") intern,
  @JsonValue("Junior") junior,
  @JsonValue("Middle") middle,
  @JsonValue("Senior") senior,
  @JsonValue("Lead") lead;

  String get displayName {
    switch (this) {
      case LevelType.intern: return 'Intern';
      case LevelType.junior: return 'Junior';
      case LevelType.middle: return 'Middle';
      case LevelType.senior: return 'Senior';
      case LevelType.lead: return 'Lead';
    }
  }
}

@freezed
abstract class Applicant with _$Applicant {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory Applicant({
    required int id,
    required String name,
    @JsonKey(toJson: _dateTimeToJson) required DateTime dateOfBirth,
    required EducationType education,
    required String university,
    required bool graduated,
    required SpecialtyType specialty,
    required LevelType level,
    required int experience,
    @Default("") String workHistory,
    @Default([]) List<String> languages,
    @Default([]) List<String> technologies,
    @Default(0) int score,
  }) = _Applicant;

  factory Applicant.fromJson(Map<String, dynamic> json) => _$ApplicantFromJson(json);
}

String _dateTimeToJson(DateTime date) => 
    "${date.year.toString().padLeft(4, '0')}-"
    "${date.month.toString().padLeft(2, '0')}-"
    "${date.day.toString().padLeft(2, '0')}T00:00:00Z";

String? _listToQuery(List<String> list) => list.isEmpty ? null : list.join(',');

@freezed
abstract class PublicationRequestForApplicant with _$PublicationRequestForApplicant {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory PublicationRequestForApplicant({
    required String name,
    @JsonKey(toJson: _dateTimeToJson) required DateTime dateOfBirth,
    required EducationType education,
    required String university,
    required bool graduated,
    required SpecialtyType specialty,
    required LevelType level,
    required int experience,
    @Default("") String workHistory,
    @Default([]) List<String> languages,
    @Default([]) List<String> technologies,
  }) = _PublicationRequestForApplicant;

  factory PublicationRequestForApplicant.fromJson(Map<String, dynamic> json) => _$PublicationRequestForApplicantFromJson(json);
}

@freezed
abstract class RequestForApplicant with _$RequestForApplicant {
  // ignore: invalid_annotation_target
  @JsonSerializable(includeIfNull: false)
  const factory RequestForApplicant({
    String? name,
    int? experience,
    LevelType? level,
    bool? graduated,
    EducationType? education,
    SpecialtyType? specialty,
    @JsonKey(toJson: _listToQuery) @Default([]) List<String> languagesRequired,
    @JsonKey(toJson: _listToQuery) @Default([]) List<String> languagesOptional,
    @JsonKey(toJson: _listToQuery) @Default([]) List<String> technologiesRequired,
    @JsonKey(toJson: _listToQuery) @Default([]) List<String> technologiesOptional,
  }) = _RequestForApplicant;

  factory RequestForApplicant.fromJson(Map<String, dynamic> json) => _$RequestForApplicantFromJson(json);
}
