import 'api_service.dart';

class DataService {
  static List<String> _languages = [];
  static List<String> _technologies = [];

  static List<String> get languages => _languages;
  static List<String> get technologies => _technologies;

  static Future<void> loadData() async {
    try {
      final apiService = ApiService();
      _languages = await apiService.getLanguages();
      _technologies = await apiService.getTechnologies();
    } catch (e) {
      // Fallback or empty list in case of error
      _languages = [];
      _technologies = [];
    }
  }
}
