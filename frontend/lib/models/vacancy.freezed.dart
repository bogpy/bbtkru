// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vacancy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Vacancy _$VacancyFromJson(Map<String, dynamic> json) {
  return _Vacancy.fromJson(json);
}

/// @nodoc
mixin _$Vacancy {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get companyID => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;
  int get experience => throw _privateConstructorUsedError;
  int get salary => throw _privateConstructorUsedError;
  int get hours => throw _privateConstructorUsedError;
  EmploymentType get employment => throw _privateConstructorUsedError;
  LocationType get location => throw _privateConstructorUsedError;
  List<String> get languages => throw _privateConstructorUsedError;
  List<String> get technologies => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;

  /// Serializes this Vacancy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Vacancy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VacancyCopyWith<Vacancy> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VacancyCopyWith<$Res> {
  factory $VacancyCopyWith(Vacancy value, $Res Function(Vacancy) then) =
      _$VacancyCopyWithImpl<$Res, Vacancy>;
  @useResult
  $Res call({
    int id,
    String title,
    String description,
    int companyID,
    String companyName,
    int experience,
    int salary,
    int hours,
    EmploymentType employment,
    LocationType location,
    List<String> languages,
    List<String> technologies,
    int score,
  });
}

/// @nodoc
class _$VacancyCopyWithImpl<$Res, $Val extends Vacancy>
    implements $VacancyCopyWith<$Res> {
  _$VacancyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Vacancy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? companyID = null,
    Object? companyName = null,
    Object? experience = null,
    Object? salary = null,
    Object? hours = null,
    Object? employment = null,
    Object? location = null,
    Object? languages = null,
    Object? technologies = null,
    Object? score = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            companyID: null == companyID
                ? _value.companyID
                : companyID // ignore: cast_nullable_to_non_nullable
                      as int,
            companyName: null == companyName
                ? _value.companyName
                : companyName // ignore: cast_nullable_to_non_nullable
                      as String,
            experience: null == experience
                ? _value.experience
                : experience // ignore: cast_nullable_to_non_nullable
                      as int,
            salary: null == salary
                ? _value.salary
                : salary // ignore: cast_nullable_to_non_nullable
                      as int,
            hours: null == hours
                ? _value.hours
                : hours // ignore: cast_nullable_to_non_nullable
                      as int,
            employment: null == employment
                ? _value.employment
                : employment // ignore: cast_nullable_to_non_nullable
                      as EmploymentType,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as LocationType,
            languages: null == languages
                ? _value.languages
                : languages // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            technologies: null == technologies
                ? _value.technologies
                : technologies // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VacancyImplCopyWith<$Res> implements $VacancyCopyWith<$Res> {
  factory _$$VacancyImplCopyWith(
    _$VacancyImpl value,
    $Res Function(_$VacancyImpl) then,
  ) = __$$VacancyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    String description,
    int companyID,
    String companyName,
    int experience,
    int salary,
    int hours,
    EmploymentType employment,
    LocationType location,
    List<String> languages,
    List<String> technologies,
    int score,
  });
}

/// @nodoc
class __$$VacancyImplCopyWithImpl<$Res>
    extends _$VacancyCopyWithImpl<$Res, _$VacancyImpl>
    implements _$$VacancyImplCopyWith<$Res> {
  __$$VacancyImplCopyWithImpl(
    _$VacancyImpl _value,
    $Res Function(_$VacancyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Vacancy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? companyID = null,
    Object? companyName = null,
    Object? experience = null,
    Object? salary = null,
    Object? hours = null,
    Object? employment = null,
    Object? location = null,
    Object? languages = null,
    Object? technologies = null,
    Object? score = null,
  }) {
    return _then(
      _$VacancyImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        companyID: null == companyID
            ? _value.companyID
            : companyID // ignore: cast_nullable_to_non_nullable
                  as int,
        companyName: null == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String,
        experience: null == experience
            ? _value.experience
            : experience // ignore: cast_nullable_to_non_nullable
                  as int,
        salary: null == salary
            ? _value.salary
            : salary // ignore: cast_nullable_to_non_nullable
                  as int,
        hours: null == hours
            ? _value.hours
            : hours // ignore: cast_nullable_to_non_nullable
                  as int,
        employment: null == employment
            ? _value.employment
            : employment // ignore: cast_nullable_to_non_nullable
                  as EmploymentType,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as LocationType,
        languages: null == languages
            ? _value._languages
            : languages // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        technologies: null == technologies
            ? _value._technologies
            : technologies // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VacancyImpl implements _Vacancy {
  const _$VacancyImpl({
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
    final List<String> languages = const [],
    final List<String> technologies = const [],
    this.score = 0,
  }) : _languages = languages,
       _technologies = technologies;

  factory _$VacancyImpl.fromJson(Map<String, dynamic> json) =>
      _$$VacancyImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String description;
  @override
  final int companyID;
  @override
  final String companyName;
  @override
  final int experience;
  @override
  final int salary;
  @override
  final int hours;
  @override
  final EmploymentType employment;
  @override
  final LocationType location;
  final List<String> _languages;
  @override
  @JsonKey()
  List<String> get languages {
    if (_languages is EqualUnmodifiableListView) return _languages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languages);
  }

  final List<String> _technologies;
  @override
  @JsonKey()
  List<String> get technologies {
    if (_technologies is EqualUnmodifiableListView) return _technologies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_technologies);
  }

  @override
  @JsonKey()
  final int score;

  @override
  String toString() {
    return 'Vacancy(id: $id, title: $title, description: $description, companyID: $companyID, companyName: $companyName, experience: $experience, salary: $salary, hours: $hours, employment: $employment, location: $location, languages: $languages, technologies: $technologies, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VacancyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.companyID, companyID) ||
                other.companyID == companyID) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.salary, salary) || other.salary == salary) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.employment, employment) ||
                other.employment == employment) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(
              other._languages,
              _languages,
            ) &&
            const DeepCollectionEquality().equals(
              other._technologies,
              _technologies,
            ) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    companyID,
    companyName,
    experience,
    salary,
    hours,
    employment,
    location,
    const DeepCollectionEquality().hash(_languages),
    const DeepCollectionEquality().hash(_technologies),
    score,
  );

  /// Create a copy of Vacancy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VacancyImplCopyWith<_$VacancyImpl> get copyWith =>
      __$$VacancyImplCopyWithImpl<_$VacancyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VacancyImplToJson(this);
  }
}

abstract class _Vacancy implements Vacancy {
  const factory _Vacancy({
    required final int id,
    required final String title,
    required final String description,
    required final int companyID,
    required final String companyName,
    required final int experience,
    required final int salary,
    required final int hours,
    required final EmploymentType employment,
    required final LocationType location,
    final List<String> languages,
    final List<String> technologies,
    final int score,
  }) = _$VacancyImpl;

  factory _Vacancy.fromJson(Map<String, dynamic> json) = _$VacancyImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get description;
  @override
  int get companyID;
  @override
  String get companyName;
  @override
  int get experience;
  @override
  int get salary;
  @override
  int get hours;
  @override
  EmploymentType get employment;
  @override
  LocationType get location;
  @override
  List<String> get languages;
  @override
  List<String> get technologies;
  @override
  int get score;

  /// Create a copy of Vacancy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VacancyImplCopyWith<_$VacancyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RequestForVacancy _$RequestForVacancyFromJson(Map<String, dynamic> json) {
  return _RequestForVacancy.fromJson(json);
}

/// @nodoc
mixin _$RequestForVacancy {
  int? get experience => throw _privateConstructorUsedError;
  int? get salary => throw _privateConstructorUsedError;
  EmploymentType? get employment => throw _privateConstructorUsedError;
  LocationType? get location => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  int? get hours => throw _privateConstructorUsedError;

  /// Serializes this RequestForVacancy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequestForVacancy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequestForVacancyCopyWith<RequestForVacancy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestForVacancyCopyWith<$Res> {
  factory $RequestForVacancyCopyWith(
    RequestForVacancy value,
    $Res Function(RequestForVacancy) then,
  ) = _$RequestForVacancyCopyWithImpl<$Res, RequestForVacancy>;
  @useResult
  $Res call({
    int? experience,
    int? salary,
    EmploymentType? employment,
    LocationType? location,
    String? country,
    int? hours,
  });
}

/// @nodoc
class _$RequestForVacancyCopyWithImpl<$Res, $Val extends RequestForVacancy>
    implements $RequestForVacancyCopyWith<$Res> {
  _$RequestForVacancyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestForVacancy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? experience = freezed,
    Object? salary = freezed,
    Object? employment = freezed,
    Object? location = freezed,
    Object? country = freezed,
    Object? hours = freezed,
  }) {
    return _then(
      _value.copyWith(
            experience: freezed == experience
                ? _value.experience
                : experience // ignore: cast_nullable_to_non_nullable
                      as int?,
            salary: freezed == salary
                ? _value.salary
                : salary // ignore: cast_nullable_to_non_nullable
                      as int?,
            employment: freezed == employment
                ? _value.employment
                : employment // ignore: cast_nullable_to_non_nullable
                      as EmploymentType?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as LocationType?,
            country: freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String?,
            hours: freezed == hours
                ? _value.hours
                : hours // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RequestForVacancyImplCopyWith<$Res>
    implements $RequestForVacancyCopyWith<$Res> {
  factory _$$RequestForVacancyImplCopyWith(
    _$RequestForVacancyImpl value,
    $Res Function(_$RequestForVacancyImpl) then,
  ) = __$$RequestForVacancyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? experience,
    int? salary,
    EmploymentType? employment,
    LocationType? location,
    String? country,
    int? hours,
  });
}

/// @nodoc
class __$$RequestForVacancyImplCopyWithImpl<$Res>
    extends _$RequestForVacancyCopyWithImpl<$Res, _$RequestForVacancyImpl>
    implements _$$RequestForVacancyImplCopyWith<$Res> {
  __$$RequestForVacancyImplCopyWithImpl(
    _$RequestForVacancyImpl _value,
    $Res Function(_$RequestForVacancyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestForVacancy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? experience = freezed,
    Object? salary = freezed,
    Object? employment = freezed,
    Object? location = freezed,
    Object? country = freezed,
    Object? hours = freezed,
  }) {
    return _then(
      _$RequestForVacancyImpl(
        experience: freezed == experience
            ? _value.experience
            : experience // ignore: cast_nullable_to_non_nullable
                  as int?,
        salary: freezed == salary
            ? _value.salary
            : salary // ignore: cast_nullable_to_non_nullable
                  as int?,
        employment: freezed == employment
            ? _value.employment
            : employment // ignore: cast_nullable_to_non_nullable
                  as EmploymentType?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as LocationType?,
        country: freezed == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String?,
        hours: freezed == hours
            ? _value.hours
            : hours // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$RequestForVacancyImpl implements _RequestForVacancy {
  const _$RequestForVacancyImpl({
    this.experience,
    this.salary,
    this.employment,
    this.location,
    this.country,
    this.hours,
  });

  factory _$RequestForVacancyImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestForVacancyImplFromJson(json);

  @override
  final int? experience;
  @override
  final int? salary;
  @override
  final EmploymentType? employment;
  @override
  final LocationType? location;
  @override
  final String? country;
  @override
  final int? hours;

  @override
  String toString() {
    return 'RequestForVacancy(experience: $experience, salary: $salary, employment: $employment, location: $location, country: $country, hours: $hours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestForVacancyImpl &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.salary, salary) || other.salary == salary) &&
            (identical(other.employment, employment) ||
                other.employment == employment) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.hours, hours) || other.hours == hours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    experience,
    salary,
    employment,
    location,
    country,
    hours,
  );

  /// Create a copy of RequestForVacancy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestForVacancyImplCopyWith<_$RequestForVacancyImpl> get copyWith =>
      __$$RequestForVacancyImplCopyWithImpl<_$RequestForVacancyImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestForVacancyImplToJson(this);
  }
}

abstract class _RequestForVacancy implements RequestForVacancy {
  const factory _RequestForVacancy({
    final int? experience,
    final int? salary,
    final EmploymentType? employment,
    final LocationType? location,
    final String? country,
    final int? hours,
  }) = _$RequestForVacancyImpl;

  factory _RequestForVacancy.fromJson(Map<String, dynamic> json) =
      _$RequestForVacancyImpl.fromJson;

  @override
  int? get experience;
  @override
  int? get salary;
  @override
  EmploymentType? get employment;
  @override
  LocationType? get location;
  @override
  String? get country;
  @override
  int? get hours;

  /// Create a copy of RequestForVacancy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestForVacancyImplCopyWith<_$RequestForVacancyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
