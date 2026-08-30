class Vacancy {
  final int id;
  final String title;
  final String description;
  final int companyID;
  final String companyName;
  final int experience;
  final int salary;
  final int hours;
  final EmploymentType employment;
  final LocationType location;
  final List<String> languages;
  final List<String> technologies;
  final int score;

  Vacancy({
    required this.id,
    required this.title,
    required this.description,
    required this.companyID,
    required this.companyName,
    required this.experience,
    required this.salary,
    required this.hours,
    required this.employment,
    required this.location,
    this.languages = const [],
    this.technologies = const [],
    this.score = 0,
  });

  factory Vacancy.fromJson(Map<String, dynamic> json) {
    final List<String> langs =
        (json['Languages'] as List?)?.cast<String>() ??
        (json['languages'] as List?)?.cast<String>() ??
        const [];

    final List<String> techs =
        (json['Technologies'] as List?)?.cast<String>() ??
        (json['technologies'] as List?)?.cast<String>() ??
        const [];

    return Vacancy(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      companyID: json['companyID'] as int? ?? 0,
      companyName: json['companyName'] as String? ?? '',
      experience: json['experience'] as int? ?? 0,
      salary: json['salary'] as int? ?? 0,
      hours: json['hours'] as int? ?? 0,
      employment: _parseEmployment(json['employment']),
      location: _parseLocation(json['location']),
      languages: langs,
      technologies: techs,
      score: json['score'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'companyID': companyID,
    'companyName': companyName,
    'experience': experience,
    'salary': salary,
    'hours': hours,
    'employment': employment.displayName,
    'location': location.displayName,
    'languages': languages,
    'technologies': technologies,
    'score': score,
  };

  static EmploymentType _parseEmployment(dynamic value) {
    if (value == 'Internship') {
      return EmploymentType.internship;
    }
    if (value == 'Part-time') {
      return EmploymentType.partTime;
    }
    return EmploymentType.fullTime;
  }

  static LocationType _parseLocation(dynamic value) {
    if (value == 'Remote') {
      return LocationType.remote;
    }
    if (value == 'Hybrid') {
      return LocationType.hybrid;
    }
    return LocationType.inOffice;
  }
}

enum EmploymentType {
  internship,
  fullTime,
  partTime;

  String get displayName {
    switch (this) {
      case EmploymentType.internship:
        return 'Internship';
      case EmploymentType.fullTime:
        return 'Full-time';
      case EmploymentType.partTime:
        return 'Part-time';
    }
  }
}

enum LocationType {
  remote,
  hybrid,
  inOffice;

  String get displayName {
    switch (this) {
      case LocationType.remote:
        return 'Remote';
      case LocationType.hybrid:
        return 'Hybrid';
      case LocationType.inOffice:
        return 'In-office';
    }
  }
}

class RequestForVacancy {
  static const Object _unset = Object();

  final String? title;
  final int? experience;
  final int? salary;
  final EmploymentType? employment;
  final LocationType? location;
  final String? country;
  final int? hours;
  final List<String> languages;
  final List<String> technologies;

  RequestForVacancy({
    this.title,
    this.experience,
    this.salary,
    this.employment,
    this.location,
    this.country,
    this.hours,
    this.languages = const [],
    this.technologies = const [],
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (title != null && title!.trim().isNotEmpty) {
      map['title'] = title!.trim();
    }
    if (experience != null) {
      map['experience'] = experience;
    }
    if (salary != null) {
      map['salary'] = salary;
    }
    if (employment != null) {
      map['employment'] = employment!.displayName;
    }
    if (location != null) {
      map['location'] = location!.displayName;
    }
    if (country != null && country!.trim().isNotEmpty) {
      map['country'] = country!.trim();
    }
    if (hours != null) {
      map['hours'] = hours;
    }
    if (languages.isNotEmpty) {
      map['languages'] = languages.join(',');
    }
    if (technologies.isNotEmpty) {
      map['technologies'] = technologies.join(',');
    }

    return map;
  }

  RequestForVacancy copyWith({
    Object? title = _unset,
    Object? experience = _unset,
    Object? salary = _unset,
    Object? employment = _unset,
    Object? location = _unset,
    Object? country = _unset,
    Object? hours = _unset,
    List<String>? languages,
    List<String>? technologies,
  }) {
    return RequestForVacancy(
      title: identical(title, _unset) ? this.title : title as String?,
      experience: identical(experience, _unset)
          ? this.experience
          : experience as int?,
      salary: identical(salary, _unset) ? this.salary : salary as int?,
      employment: identical(employment, _unset)
          ? this.employment
          : employment as EmploymentType?,
      location: identical(location, _unset)
          ? this.location
          : location as LocationType?,
      country: identical(country, _unset) ? this.country : country as String?,
      hours: identical(hours, _unset) ? this.hours : hours as int?,
      languages: languages ?? this.languages,
      technologies: technologies ?? this.technologies,
    );
  }
}
