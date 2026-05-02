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

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      country: json['country'] as String? ?? '',
      yearFound: json['yearFound'] as int? ?? 0,
      employeeCount: json['employeeCount'] as int? ?? 0,
      vacancies: (json['vacancies'] as List?)
              ?.map((e) => Vacancy.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      score: json['score'] as int? ?? 0,
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
  final String? name;
  final String? country;
  final int? employeeCount;

  RequestForCompany({this.name, this.country, this.employeeCount});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (name != null) map['name'] = name;
    if (country != null) map['country'] = country;
    if (employeeCount != null) map['employeeCount'] = employeeCount;
    return map;
  }

  RequestForCompany copyWith({String? name, String? country, int? employeeCount}) {
    return RequestForCompany(
      name: name ?? this.name,
      country: country ?? this.country,
      employeeCount: employeeCount ?? this.employeeCount,
    );
  }
}
