import 'package:freezed_annotation/freezed_annotation.dart';

part 'vacancy.freezed.dart';
part 'vacancy.g.dart';

enum EmploymentType {
  @JsonValue("Internship") internship,
  @JsonValue("Full-time") fullTime,
  @JsonValue("Part-time") partTime;
}

enum LocationType {
  @JsonValue("Remote") remote,
  @JsonValue("Hybrid") hybrid,
  @JsonValue("In-office") inOffice;
}

@freezed
class Vacancy with _$Vacancy {
  const factory Vacancy({
    required int id,
    required String title,
    required String description,
    
    required int companyID,
    required String companyName,
    
    required int experience,
    required int salary,
    required int hours,
    required EmploymentType employment,
    required LocationType location,
    
    @Default([]) List<String> languages,
    @Default([]) List<String> technologies,
    @Default(0) int score,
  }) = _Vacancy;

  factory Vacancy.fromJson(Map<String, dynamic> json) => _$VacancyFromJson(json);
}

@freezed
class RequestForVacancy with _$RequestForVacancy {
  const factory RequestForVacancy({
    int? experience,
    int? salary,
    EmploymentType? employment,
    LocationType? location,
    String? country,
    int? hours,
  }) = _RequestForVacancy;

  factory RequestForVacancy.fromJson(Map<String, dynamic> json) => _$RequestForVacancyFromJson(json);
}