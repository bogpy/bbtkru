import 'package:dio/dio.dart';
import '../models/applicant.dart';
import '../models/company.dart';
import '../models/vacancy.dart';

class ApiService {
  static const String _baseUrl = 'http://158.160.175.91:8080';
  
  final Dio _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    headers: {'Content-Type': 'application/json'},
  ));

  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();


  Future<Applicant> getApplicant(int id) async {
    try {
      final response = await _dio.get('/applicants/$id');
      return Applicant.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Company> getCompany(int id) async {
    try {
      final response = await _dio.get('/companies/$id');
      return Company.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  Future<Vacancy> getVacancy(int id) async {
    try {
      final response = await _dio.get('/vacancies/$id');
      return Vacancy.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  Future<List<Vacancy>> getCompanies() async {
    try {
      final response = await _dio.get('/vacancies');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Vacancy.fromJson(json)).toList();
      }
      throw Exception('Failed to load vacancies');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  Future<List<Vacancy>> getVacancies() async {
    try {
      final response = await _dio.get('/vacancies');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Vacancy.fromJson(json)).toList();
      }
      throw Exception('Failed to load vacancies');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  Future<List<Vacancy>> getApplicants() async {
    try {
      final response = await _dio.get('/vacancies');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Vacancy.fromJson(json)).toList();
      }
      throw Exception('Failed to load vacancies');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) return "Check your internet.";
    if (e.response?.statusCode == 403) return "IP Not Whitelisted (CORS/IP Error).";
    return e.message ?? "Something went wrong.";
  }
}