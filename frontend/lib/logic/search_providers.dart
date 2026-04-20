import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:headless_hunter_frontend/models/vacancy.dart';
import 'package:headless_hunter_frontend/models/applicant.dart';
import 'package:headless_hunter_frontend/models/company.dart';
import 'package:headless_hunter_frontend/services/api_service.dart';
import 'package:dio/dio.dart';
import 'dart:async';

// --- Vacancy ---

class VacancyRequestNotifier extends Notifier<RequestForVacancy> {
  @override
  RequestForVacancy build() => const RequestForVacancy();
  void update(RequestForVacancy value) => state = value;
  void reset() => state = const RequestForVacancy();
}

final vacancyRequestProvider = NotifierProvider<VacancyRequestNotifier, RequestForVacancy>(VacancyRequestNotifier.new);

class VacancySearchTextNotifier extends Notifier<String> {
  @override
  String build() => "";
  void update(String value) => state = value;
  void reset() => state = "";
}

final vacancySearchTextProvider = NotifierProvider<VacancySearchTextNotifier, String>(VacancySearchTextNotifier.new);

final vacanciesProvider = FutureProvider<List<Vacancy>>((ref) async {
  final request = ref.watch(vacancyRequestProvider);
  final searchText = ref.watch(vacancySearchTextProvider);
  
  // Throttle API calls
  await Future.delayed(const Duration(milliseconds: 500));
  
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  
  final finalRequest = request.copyWith(title: searchText.isEmpty ? null : searchText);
  return ApiService().getVacancies(finalRequest, cancelToken: cancelToken);
});

// --- Applicant ---

class ApplicantRequestNotifier extends Notifier<RequestForApplicant> {
  @override
  RequestForApplicant build() => const RequestForApplicant();
  void update(RequestForApplicant value) => state = value;
  void reset() => state = const RequestForApplicant();
}

final applicantRequestProvider = NotifierProvider<ApplicantRequestNotifier, RequestForApplicant>(ApplicantRequestNotifier.new);

class ApplicantSearchTextNotifier extends Notifier<String> {
  @override
  String build() => "";
  void update(String value) => state = value;
  void reset() => state = "";
}

final applicantSearchTextProvider = NotifierProvider<ApplicantSearchTextNotifier, String>(ApplicantSearchTextNotifier.new);

final applicantsProvider = FutureProvider<List<Applicant>>((ref) async {
  final request = ref.watch(applicantRequestProvider);
  final searchText = ref.watch(applicantSearchTextProvider);
  
  await Future.delayed(const Duration(milliseconds: 500));
  
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  
  final finalRequest = request.copyWith(name: searchText.isEmpty ? null : searchText);
  return ApiService().getApplicants(finalRequest, cancelToken: cancelToken);
});

// --- Company ---

class CompanyRequestNotifier extends Notifier<RequestForCompany> {
  @override
  RequestForCompany build() => const RequestForCompany();
  void update(RequestForCompany value) => state = value;
  void reset() => state = const RequestForCompany();
}

final companyRequestProvider = NotifierProvider<CompanyRequestNotifier, RequestForCompany>(CompanyRequestNotifier.new);

class CompanySearchTextNotifier extends Notifier<String> {
  @override
  String build() => "";
  void update(String value) => state = value;
  void reset() => state = "";
}

final companySearchTextProvider = NotifierProvider<CompanySearchTextNotifier, String>(CompanySearchTextNotifier.new);

final companiesProvider = FutureProvider<List<Company>>((ref) async {
  final request = ref.watch(companyRequestProvider);
  final searchText = ref.watch(companySearchTextProvider);
  
  await Future.delayed(const Duration(milliseconds: 500));
  
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  
  final finalRequest = request.copyWith(name: searchText.isEmpty ? null : searchText);
  return ApiService().getCompanies(finalRequest, cancelToken: cancelToken);
});
