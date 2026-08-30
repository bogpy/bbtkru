import 'package:headless_hunter_frontend/models/vacancy.dart';

class Company {
  final int id;
  final String name;
  final String country;
  final int yearFound;
  final int employeeCount;
  final List<Vacancy> vacancies;
  final int score;

  Company({
    required this.id,
    required this.name,
    required this.country,
    required this.yearFound,
    required this.employeeCount,
    this.vacancies = const [],
    this.score = 0,
  });

  String get initial {
    final trimmedName = name.trim();
    return trimmedName.isEmpty ? '?' : trimmedName[0].toUpperCase();
  }

  factory Company.fromJson(Map<String, dynamic> json) {
    final rawVacancies = json['vacancies'] ?? json['Vacancies'];
    return Company(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      country: json['country'] as String? ?? '',
      yearFound: json['yearFound'] as int? ?? 0,
      employeeCount: json['employeeCount'] as int? ?? 0,
      vacancies:
          (rawVacancies as List?)
              ?.map((e) => Vacancy.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      score: (json['score'] ?? json['Score']) as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'country': country,
    'yearFound': yearFound,
    'employeeCount': employeeCount,
    'vacancies': vacancies.map((v) => v.toJson()).toList(),
    'score': score,
  };
}

class RequestForCompany {
  static const Object _unset = Object();

  final String? name;
  final String? country;
  final int? employeeCount;

  RequestForCompany({this.name, this.country, this.employeeCount});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (name != null && name!.trim().isNotEmpty) map['name'] = name!.trim();
    if (country != null && country!.trim().isNotEmpty) {
      map['country'] = country!.trim();
    }
    if (employeeCount != null) map['employeeCount'] = employeeCount;
    return map;
  }

  RequestForCompany copyWith({
    Object? name = _unset,
    Object? country = _unset,
    Object? employeeCount = _unset,
  }) {
    return RequestForCompany(
      name: identical(name, _unset) ? this.name : name as String?,
      country: identical(country, _unset) ? this.country : country as String?,
      employeeCount: identical(employeeCount, _unset)
          ? this.employeeCount
          : employeeCount as int?,
    );
  }
}
