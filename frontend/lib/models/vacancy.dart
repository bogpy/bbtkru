import 'package:freezed_annotation/freezed_annotation.dart';

part 'vacancy.freezed.dart';
part 'vacancy.g.dart';

enum EmploymentType {
  @JsonValue("Internship") internship,
  @JsonValue("Full-time") fullTime,
  @JsonValue("Part-time") partTime;

  String get displayName {
    switch (this) {
      case EmploymentType.internship: return 'Internship';
      case EmploymentType.fullTime: return 'Full-time';
      case EmploymentType.partTime: return 'Part-time';
    }
  }
}

enum LocationType {
  @JsonValue("Remote") remote,
  @JsonValue("Hybrid") hybrid,
  @JsonValue("In-office") inOffice;

  String get displayName {
    switch (this) {
      case LocationType.remote: return 'Remote';
      case LocationType.hybrid: return 'Hybrid';
      case LocationType.inOffice: return 'In-office';
    }
  }
}

@freezed
abstract class Vacancy with _$Vacancy {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
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

String? _listToQuery(List<String> list) => list.isEmpty ? null : list.join(',');

@freezed
abstract class RequestForVacancy with _$RequestForVacancy {
  // ignore: invalid_annotation_target
  @JsonSerializable(includeIfNull: false)
  const factory RequestForVacancy({
    String? title,
    int? experience,
    int? salary,
    EmploymentType? employment,
    LocationType? location,
    String? country,
    int? hours,
    @JsonKey(toJson: _listToQuery) @Default([]) List<String> languages,
    @JsonKey(toJson: _listToQuery) @Default([]) List<String> technologies,
  }) = _RequestForVacancy;

  factory RequestForVacancy.fromJson(Map<String, dynamic> json) => _$RequestForVacancyFromJson(json);
}
