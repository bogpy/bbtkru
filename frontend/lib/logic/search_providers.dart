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
}

final vacancyRequestProvider = NotifierProvider<VacancyRequestNotifier, RequestForVacancy>(VacancyRequestNotifier.new);

final vacanciesProvider = FutureProvider<List<Vacancy>>((ref) async {
  final request = ref.watch(vacancyRequestProvider);
  await Future.delayed(const Duration(milliseconds: 350));
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  return ApiService().getVacancies(request, cancelToken: cancelToken);
});

class VacancySearchTextNotifier extends Notifier<String> {
  @override
  String build() => "";
  void update(String value) => state = value;
}

final vacancySearchTextProvider = NotifierProvider<VacancySearchTextNotifier, String>(VacancySearchTextNotifier.new);

// --- Applicant ---

class ApplicantRequestNotifier extends Notifier<RequestForApplicant> {
  @override
  RequestForApplicant build() => const RequestForApplicant();
  void update(RequestForApplicant value) => state = value;
}

final applicantRequestProvider = NotifierProvider<ApplicantRequestNotifier, RequestForApplicant>(ApplicantRequestNotifier.new);

final applicantsProvider = FutureProvider<List<Applicant>>((ref) async {
  final request = ref.watch(applicantRequestProvider);
  await Future.delayed(const Duration(milliseconds: 350));
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  return ApiService().getApplicants(request, cancelToken: cancelToken);
});

class ApplicantSearchTextNotifier extends Notifier<String> {
  @override
  String build() => "";
  void update(String value) => state = value;
}

final applicantSearchTextProvider = NotifierProvider<ApplicantSearchTextNotifier, String>(ApplicantSearchTextNotifier.new);

// --- Company ---

class CompanyRequestNotifier extends Notifier<RequestForCompany> {
  @override
  RequestForCompany build() => const RequestForCompany();
  void update(RequestForCompany value) => state = value;
}

final companyRequestProvider = NotifierProvider<CompanyRequestNotifier, RequestForCompany>(CompanyRequestNotifier.new);

final companiesProvider = FutureProvider<List<Company>>((ref) async {
  final request = ref.watch(companyRequestProvider);
  await Future.delayed(const Duration(milliseconds: 350));
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  return ApiService().getCompanies(request, cancelToken: cancelToken);
});

class CompanySearchTextNotifier extends Notifier<String> {
  @override
  String build() => "";
  void update(String value) => state = value;
}

final companySearchTextProvider = NotifierProvider<CompanySearchTextNotifier, String>(CompanySearchTextNotifier.new);
