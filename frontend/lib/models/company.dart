import 'package:freezed_annotation/freezed_annotation.dart';
import 'vacancy.dart'; 

part 'company.freezed.dart';
part 'company.g.dart';

@freezed
abstract class Company with _$Company {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory Company({
    required int id,
    required String name,
    required String country,
    required int yearFound,
    required int employeeCount,
    @Default([]) List<Vacancy> vacancies,
    @Default(0) int score,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);
}

@freezed
abstract class RequestForCompany with _$RequestForCompany {
  // ignore: invalid_annotation_target
  @JsonSerializable(includeIfNull: false)
  const factory RequestForCompany({
    String? name,
    String? country,
    int? employeeCount,
  }) = _RequestForCompany;

  factory RequestForCompany.fromJson(Map<String, dynamic> json) => _$RequestForCompanyFromJson(json);
}
