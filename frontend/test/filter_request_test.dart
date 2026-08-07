import 'package:flutter_test/flutter_test.dart';
import 'package:headless_hunter_frontend/models/applicant.dart';
import 'package:headless_hunter_frontend/models/company.dart';
import 'package:headless_hunter_frontend/models/vacancy.dart';

void main() {
  test('company without vacancies is safe to open', () {
    final company = Company.fromJson({
      'id': 1,
      'name': 'New Company',
      'country': 'USA',
      'yearFound': 2026,
      'employeeCount': 0,
      'Vacancies': null,
      'Score': 0,
    });

    expect(company.vacancies, isEmpty);
    expect(company.initial, 'N');

    final unnamed = Company(
      id: 2,
      name: '',
      country: '',
      yearFound: 0,
      employeeCount: 0,
    );
    expect(unnamed.initial, '?');
  });

  test('applicant API enums are parsed without falling back', () {
    final applicant = Applicant.fromJson({
      'id': 1,
      'name': 'Alice',
      'dateOfBirth': '2000-01-02T00:00:00Z',
      'education': 'HighSchool',
      'university': 'Example University',
      'graduated': true,
      'specialty': 'DataEngineer',
      'level': 'Intern',
      'experience': 1,
    });

    expect(applicant.education, EducationType.highSchool);
    expect(applicant.specialty, SpecialtyType.dataEngineer);
    expect(applicant.level, LevelType.intern);
  });

  test('applicant filters use API values and can be cleared', () {
    final request = RequestForApplicant(
      name: '  Alice  ',
      experience: 2,
      level: LevelType.junior,
      graduated: true,
      education: EducationType.bachelor,
      specialty: SpecialtyType.backend,
    );

    expect(request.toJson(), {
      'name': 'Alice',
      'experience': 2,
      'level': 'Junior',
      'graduated': true,
      'education': 'Bachelor',
      'specialty': 'Backend',
    });

    final cleared = request.copyWith(
      name: null,
      experience: null,
      level: null,
      graduated: null,
      education: null,
      specialty: null,
    );
    expect(cleared.toJson(), isEmpty);
  });

  test('vacancy filters use API values and can be cleared', () {
    final request = RequestForVacancy(
      title: '  Flutter  ',
      experience: 3,
      salary: 5000,
      employment: EmploymentType.fullTime,
      location: LocationType.remote,
      country: '  USA  ',
      hours: 40,
    );

    expect(request.toJson(), {
      'title': 'Flutter',
      'experience': 3,
      'salary': 5000,
      'employment': 'Full-time',
      'location': 'Remote',
      'country': 'USA',
      'hours': 40,
    });

    final cleared = request.copyWith(
      title: null,
      experience: null,
      salary: null,
      employment: null,
      location: null,
      country: null,
      hours: null,
    );
    expect(cleared.toJson(), isEmpty);
  });

  test('company filters ignore blank text and can be cleared', () {
    final request = RequestForCompany(
      name: '  Acme  ',
      country: '   ',
      employeeCount: 20,
    );

    expect(request.toJson(), {'name': 'Acme', 'employeeCount': 20});

    final cleared = request.copyWith(
      name: null,
      country: null,
      employeeCount: null,
    );
    expect(cleared.toJson(), isEmpty);
  });
}
