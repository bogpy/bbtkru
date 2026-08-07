import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/applicant.dart';
import '../models/company.dart';
import '../models/vacancy.dart';
import '../models/user.dart';

List<Map<String, dynamic>> _decodeObjectList(dynamic data) {
  if (data == null) return const [];
  if (data is! List) {
    throw const FormatException('Expected a list response');
  }

  return data.map((item) {
    if (item is! Map) {
      throw const FormatException('Expected an object in list response');
    }
    return Map<String, dynamic>.from(item);
  }).toList();
}

class ApiService {
  static const String _baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8080',
  );

  late final Dio _dio;

  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Interceptor for Auth Token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  // --- Auth ---

  Future<(User, String)> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      final user = User.fromJson(response.data['user']);
      final token = response.data['token'] as String;
      return (user, token);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<(User, String)> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {'name': name, 'email': email, 'password': password},
      );
      final user = User.fromJson(response.data['user']);
      final token = response.data['token'] as String;
      return (user, token);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> getMe() async {
    try {
      final response = await _dio.get('/auth/me');
      return User.fromJson(response.data['user']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // --- Data Fetching ---

  Future<Applicant> getApplicant(int id) async {
    try {
      final response = await _dio.get('/applicants/$id');
      return Applicant.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Vacancy>> getCompanyVacancies(int id) async {
    try {
      final response = await _dio.get('/companies/vacancies/$id');
      if (response.statusCode == 200) {
        return _decodeObjectList(response.data).map(Vacancy.fromJson).toList();
      }
      throw Exception('Failed to load company vacancies');
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

  Future<List<Company>> getCompanies(
    RequestForCompany request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        '/companies',
        queryParameters: request.toJson(),
        cancelToken: cancelToken,
      );
      if (response.statusCode == 200) {
        return _decodeObjectList(response.data).map(Company.fromJson).toList();
      }
      throw Exception('Failed to load companies');
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) throw Exception('Cancelled');
      throw _handleError(e);
    }
  }

  Future<List<Vacancy>> getVacancies(
    RequestForVacancy request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        '/vacancies',
        queryParameters: request.toJson(),
        cancelToken: cancelToken,
      );
      if (response.statusCode == 200) {
        return _decodeObjectList(response.data).map(Vacancy.fromJson).toList();
      }
      throw Exception('Failed to load vacancies');
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) throw Exception('Cancelled');
      throw _handleError(e);
    }
  }

  Future<List<Applicant>> getApplicants(
    RequestForApplicant request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        '/applicants',
        queryParameters: request.toJson(),
        cancelToken: cancelToken,
      );
      if (response.statusCode == 200) {
        return _decodeObjectList(
          response.data,
        ).map(Applicant.fromJson).toList();
      }
      throw Exception('Failed to load applicants');
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) throw Exception('Cancelled');
      throw _handleError(e);
    }
  }

  Future<List<String>> getLanguages() async {
    try {
      final response = await _dio.get('/languages');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.cast<String>();
      }
      throw Exception('Failed to load languages');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<String>> getTechnologies() async {
    try {
      final response = await _dio.get('/technologies');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.cast<String>();
      }
      throw Exception('Failed to load technologies');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Company>> getMyCompanies() async {
    try {
      final response = await _dio.get('/private/companies');
      return _decodeObjectList(response.data).map(Company.fromJson).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // --- Creation ---

  Future<void> createApplicant(PublicationRequestForApplicant request) async {
    try {
      await _dio.post('/private/applicants', data: request.toJson());
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Company> createCompany(Company company) async {
    try {
      final response = await _dio.post(
        '/private/companies',
        data: company.toJson(),
      );
      return Company.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> createVacancy(Vacancy vacancy) async {
    try {
      await _dio.post('/private/vacancies', data: vacancy.toJson());
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return "Check your internet.";
    }

    final responseData = e.response?.data;
    if (responseData is Map<String, dynamic>) {
      final serverMessage = responseData['error'] ?? responseData['message'];
      if (serverMessage is String && serverMessage.isNotEmpty) {
        return serverMessage;
      }
    }

    if (e.response?.statusCode == 403) {
      return "IP Not Whitelisted (CORS/IP Error).";
    }
    if (e.response?.statusCode == 401) {
      return "Unauthorized. Please login again.";
    }
    return e.message ?? "Something went wrong.";
  }
}
