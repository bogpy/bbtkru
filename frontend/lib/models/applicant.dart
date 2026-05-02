class Applicant {
  final int id;
  final String name;
  final DateTime dateOfBirth;
  final EducationType education;
  final String university;
  final bool graduated;
  final SpecialtyType specialty;
  final LevelType level;
  final int experience;
  final String workHistory;
  final List<String> languages;
  final List<String> technologies;
  final int score;

  Applicant({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.education,
    required this.university,
    required this.graduated,
    required this.specialty,
    required this.level,
    required this.experience,
    this.workHistory = '',
    this.languages = const [],
    this.technologies = const [],
    this.score = 0,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) {
    // Handle capitalized "Languages" and "Technologies" from API
    final List<String> langs = (json['Languages'] as List?)?.cast<String>() ?? 
                               (json['languages'] as List?)?.cast<String>() ?? 
                               (json['languagesRequired'] as List?)?.cast<String>() ??
                               const [];
    final List<String> techs = (json['Technologies'] as List?)?.cast<String>() ?? 
                               (json['technologies'] as List?)?.cast<String>() ?? 
                               (json['technologiesRequired'] as List?)?.cast<String>() ??
                               const [];

    return Applicant(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      dateOfBirth: DateTime.tryParse(json['dateOfBirth'] as String? ?? '') ?? DateTime.now(),
      education: _parseEducation(json['education']),
      university: json['university'] as String? ?? '',
      graduated: json['graduated'] as bool? ?? false,
      specialty: _parseSpecialty(json['specialty']),
      level: _parseLevel(json['level']),
      experience: json['experience'] as int? ?? 0,
      workHistory: json['workHistory'] as String? ?? '',
      languages: langs,
      technologies: techs,
      score: json['score'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'dateOfBirth': "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}T00:00:00Z",
        'education': education.name,
        'university': university,
        'graduated': graduated,
        'specialty': specialty.name,
        'level': level.name,
        'experience': experience,
        'workHistory': workHistory,
        'languages': languages,
        'technologies': technologies,
        'score': score,
      };

  static EducationType _parseEducation(dynamic value) {
    for (var type in EducationType.values) {
      if (type.name == value || type.displayName == value) return type;
    }
    return EducationType.bachelor;
  }
  static SpecialtyType _parseSpecialty(dynamic value) {
    for (var type in SpecialtyType.values) {
      if (type.name == value || type.displayName == value) return type;
    }
    return SpecialtyType.frontend;
  }
  static LevelType _parseLevel(dynamic value) {
    for (var type in LevelType.values) {
      if (type.name == value || type.displayName == value) return type;
    }
    return LevelType.junior;
  }
}

enum EducationType {
  highSchool, bachelor, master, phD;
  String get displayName {
    switch (this) {
      case EducationType.highSchool: return 'High School';
      case EducationType.bachelor: return 'Bachelor';
      case EducationType.master: return 'Master';
      case EducationType.phD: return 'PhD';
    }
  }
}

enum SpecialtyType {
  frontend, backend, fullstack, dataEngineer, devOps;
  String get displayName {
    switch (this) {
      case SpecialtyType.frontend: return 'Frontend';
      case SpecialtyType.backend: return 'Backend';
      case SpecialtyType.fullstack: return 'Fullstack';
      case SpecialtyType.dataEngineer: return 'Data Engineer';
      case SpecialtyType.devOps: return 'DevOps';
    }
  }
}

enum LevelType {
  intern, junior, middle, senior, lead;
  String get displayName {
    switch (this) {
      case LevelType.intern: return 'Intern';
      case LevelType.junior: return 'Junior';
      case LevelType.middle: return 'Middle';
      case LevelType.senior: return 'Senior';
      case LevelType.lead: return 'Lead';
    }
  }
}

class RequestForApplicant {
  final String? name;
  final int? experience;
  final LevelType? level;
  final bool? graduated;
  final EducationType? education;
  final SpecialtyType? specialty;
  final List<String> languagesRequired;
  final List<String> languagesOptional;
  final List<String> technologiesRequired;
  final List<String> technologiesOptional;

  RequestForApplicant({
    this.name,
    this.experience,
    this.level,
    this.graduated,
    this.education,
    this.specialty,
    this.languagesRequired = const [],
    this.languagesOptional = const [],
    this.technologiesRequired = const [],
    this.technologiesOptional = const [],
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (name != null) map['name'] = name;
    if (experience != null) map['experience'] = experience;
    if (level != null) map['level'] = level?.name;
    if (graduated != null) map['graduated'] = graduated;
    if (education != null) map['education'] = education?.name;
    if (specialty != null) map['specialty'] = specialty?.name;
    if (languagesRequired.isNotEmpty) map['languagesRequired'] = languagesRequired.join(',');
    if (languagesOptional.isNotEmpty) map['languagesOptional'] = languagesOptional.join(',');
    if (technologiesRequired.isNotEmpty) map['technologiesRequired'] = technologiesRequired.join(',');
    if (technologiesOptional.isNotEmpty) map['technologiesOptional'] = technologiesOptional.join(',');
    return map;
  }

  RequestForApplicant copyWith({
    String? name,
    int? experience,
    LevelType? level,
    bool? graduated,
    EducationType? education,
    SpecialtyType? specialty,
    List<String>? languagesRequired,
    List<String>? languagesOptional,
    List<String>? technologiesRequired,
    List<String>? technologiesOptional,
  }) {
    return RequestForApplicant(
      name: name ?? this.name,
      experience: experience ?? this.experience,
      level: level ?? this.level,
      graduated: graduated ?? this.graduated,
      education: education ?? this.education,
      specialty: specialty ?? this.specialty,
      languagesRequired: languagesRequired ?? this.languagesRequired,
      languagesOptional: languagesOptional ?? this.languagesOptional,
      technologiesRequired: technologiesRequired ?? this.technologiesRequired,
      technologiesOptional: technologiesOptional ?? this.technologiesOptional,
    );
  }
}

class PublicationRequestForApplicant {
  final String name;
  final DateTime dateOfBirth;
  final EducationType education;
  final String university;
  final bool graduated;
  final SpecialtyType specialty;
  final LevelType level;
  final int experience;
  final String workHistory;
  final List<String> languages;
  final List<String> technologies;

  PublicationRequestForApplicant({
    required this.name,
    required this.dateOfBirth,
    required this.education,
    required this.university,
    required this.graduated,
    required this.specialty,
    required this.level,
    required this.experience,
    this.workHistory = '',
    this.languages = const [],
    this.technologies = const [],
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'dateOfBirth': "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}T00:00:00Z",
        'education': education.name,
        'university': university,
        'graduated': graduated,
        'specialty': specialty.name,
        'level': level.name,
        'experience': experience,
        'workHistory': workHistory,
        'languages': languages,
        'technologies': technologies,
      };
}
