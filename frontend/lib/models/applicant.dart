import 'package:freezed_annotation/freezed_annotation.dart';

part 'applicant.freezed.dart';
part 'applicant.g.dart';

enum EducationType {
  @JsonValue("HighSchool") highSchool,
  @JsonValue("Bachelor") bachelor,
  @JsonValue("Master") master,
  @JsonValue("PhD") phD;
}

enum SpecialtyType {
  @JsonValue("Frontend") frontend,
  @JsonValue("Backend") backend,
  @JsonValue("Fullstack") fullstack,
  @JsonValue("DataEngineer") dataEngineer,
  @JsonValue("DevOps") devOps;
}

enum LevelType {
  @JsonValue("Intern") intern,
  @JsonValue("Junior") junior,
  @JsonValue("Middle") middle,
  @JsonValue("Senior") senior,
  @JsonValue("Lead") lead;
}

@freezed
class Applicant with _$Applicant {
  const factory Applicant({
    required int id,
    required String name,
    required DateTime dateOfBirth,
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

@freezed
class RequestForApplicant with _$RequestForApplicant {
  const factory RequestForApplicant({
    int? experience,
    LevelType? level,
    bool? graduated,
    EducationType? education,
    SpecialtyType? specialty,
    @Default([]) List<String> languagesRequired,
    @Default([]) List<String> languagesOptional,
    @Default([]) List<String> technologiesRequired,
    @Default([]) List<String> technologiesOptional,
  }) = _RequestForApplicant;

  factory RequestForApplicant.fromJson(Map<String, dynamic> json) => _$RequestForApplicantFromJson(json);
}