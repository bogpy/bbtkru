import 'package:freezed_annotation/freezed_annotation.dart';
import 'vacancy.dart'; 

part 'company.freezed.dart';
part 'company.g.dart';

@freezed
class Company with _$Company {
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
class RequestForCompany with _$RequestForCompany {
  const factory RequestForCompany({
    String? country,
    int? employeeCount,
  }) = _RequestForCompany;

  factory RequestForCompany.fromJson(Map<String, dynamic> json) => _$RequestForCompanyFromJson(json);
}