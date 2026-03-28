// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'applicant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Applicant _$ApplicantFromJson(Map<String, dynamic> json) {
  return _Applicant.fromJson(json);
}

/// @nodoc
mixin _$Applicant {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get dateOfBirth => throw _privateConstructorUsedError;
  EducationType get education => throw _privateConstructorUsedError;
  String get university => throw _privateConstructorUsedError;
  bool get graduated => throw _privateConstructorUsedError;
  SpecialtyType get specialty => throw _privateConstructorUsedError;
  LevelType get level => throw _privateConstructorUsedError;
  int get experience => throw _privateConstructorUsedError;
  String get workHistory => throw _privateConstructorUsedError;
  List<String> get languages => throw _privateConstructorUsedError;
  List<String> get technologies => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;

  /// Serializes this Applicant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Applicant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApplicantCopyWith<Applicant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicantCopyWith<$Res> {
  factory $ApplicantCopyWith(Applicant value, $Res Function(Applicant) then) =
      _$ApplicantCopyWithImpl<$Res, Applicant>;
  @useResult
  $Res call({
    int id,
    String name,
    DateTime dateOfBirth,
    EducationType education,
    String university,
    bool graduated,
    SpecialtyType specialty,
    LevelType level,
    int experience,
    String workHistory,
    List<String> languages,
    List<String> technologies,
    int score,
  });
}

/// @nodoc
class _$ApplicantCopyWithImpl<$Res, $Val extends Applicant>
    implements $ApplicantCopyWith<$Res> {
  _$ApplicantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Applicant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? dateOfBirth = null,
    Object? education = null,
    Object? university = null,
    Object? graduated = null,
    Object? specialty = null,
    Object? level = null,
    Object? experience = null,
    Object? workHistory = null,
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
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            dateOfBirth: null == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            education: null == education
                ? _value.education
                : education // ignore: cast_nullable_to_non_nullable
                      as EducationType,
            university: null == university
                ? _value.university
                : university // ignore: cast_nullable_to_non_nullable
                      as String,
            graduated: null == graduated
                ? _value.graduated
                : graduated // ignore: cast_nullable_to_non_nullable
                      as bool,
            specialty: null == specialty
                ? _value.specialty
                : specialty // ignore: cast_nullable_to_non_nullable
                      as SpecialtyType,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as LevelType,
            experience: null == experience
                ? _value.experience
                : experience // ignore: cast_nullable_to_non_nullable
                      as int,
            workHistory: null == workHistory
                ? _value.workHistory
                : workHistory // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$ApplicantImplCopyWith<$Res>
    implements $ApplicantCopyWith<$Res> {
  factory _$$ApplicantImplCopyWith(
    _$ApplicantImpl value,
    $Res Function(_$ApplicantImpl) then,
  ) = __$$ApplicantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    DateTime dateOfBirth,
    EducationType education,
    String university,
    bool graduated,
    SpecialtyType specialty,
    LevelType level,
    int experience,
    String workHistory,
    List<String> languages,
    List<String> technologies,
    int score,
  });
}

/// @nodoc
class __$$ApplicantImplCopyWithImpl<$Res>
    extends _$ApplicantCopyWithImpl<$Res, _$ApplicantImpl>
    implements _$$ApplicantImplCopyWith<$Res> {
  __$$ApplicantImplCopyWithImpl(
    _$ApplicantImpl _value,
    $Res Function(_$ApplicantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Applicant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? dateOfBirth = null,
    Object? education = null,
    Object? university = null,
    Object? graduated = null,
    Object? specialty = null,
    Object? level = null,
    Object? experience = null,
    Object? workHistory = null,
    Object? languages = null,
    Object? technologies = null,
    Object? score = null,
  }) {
    return _then(
      _$ApplicantImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        dateOfBirth: null == dateOfBirth
            ? _value.dateOfBirth
            : dateOfBirth // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        education: null == education
            ? _value.education
            : education // ignore: cast_nullable_to_non_nullable
                  as EducationType,
        university: null == university
            ? _value.university
            : university // ignore: cast_nullable_to_non_nullable
                  as String,
        graduated: null == graduated
            ? _value.graduated
            : graduated // ignore: cast_nullable_to_non_nullable
                  as bool,
        specialty: null == specialty
            ? _value.specialty
            : specialty // ignore: cast_nullable_to_non_nullable
                  as SpecialtyType,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as LevelType,
        experience: null == experience
            ? _value.experience
            : experience // ignore: cast_nullable_to_non_nullable
                  as int,
        workHistory: null == workHistory
            ? _value.workHistory
            : workHistory // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$ApplicantImpl implements _Applicant {
  const _$ApplicantImpl({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.education,
    required this.university,
    required this.graduated,
    required this.specialty,
    required this.level,
    required this.experience,
    this.workHistory = "",
    final List<String> languages = const [],
    final List<String> technologies = const [],
    this.score = 0,
  }) : _languages = languages,
       _technologies = technologies;

  factory _$ApplicantImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplicantImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final DateTime dateOfBirth;
  @override
  final EducationType education;
  @override
  final String university;
  @override
  final bool graduated;
  @override
  final SpecialtyType specialty;
  @override
  final LevelType level;
  @override
  final int experience;
  @override
  @JsonKey()
  final String workHistory;
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
    return 'Applicant(id: $id, name: $name, dateOfBirth: $dateOfBirth, education: $education, university: $university, graduated: $graduated, specialty: $specialty, level: $level, experience: $experience, workHistory: $workHistory, languages: $languages, technologies: $technologies, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplicantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.education, education) ||
                other.education == education) &&
            (identical(other.university, university) ||
                other.university == university) &&
            (identical(other.graduated, graduated) ||
                other.graduated == graduated) &&
            (identical(other.specialty, specialty) ||
                other.specialty == specialty) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.workHistory, workHistory) ||
                other.workHistory == workHistory) &&
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
    name,
    dateOfBirth,
    education,
    university,
    graduated,
    specialty,
    level,
    experience,
    workHistory,
    const DeepCollectionEquality().hash(_languages),
    const DeepCollectionEquality().hash(_technologies),
    score,
  );

  /// Create a copy of Applicant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplicantImplCopyWith<_$ApplicantImpl> get copyWith =>
      __$$ApplicantImplCopyWithImpl<_$ApplicantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplicantImplToJson(this);
  }
}

abstract class _Applicant implements Applicant {
  const factory _Applicant({
    required final int id,
    required final String name,
    required final DateTime dateOfBirth,
    required final EducationType education,
    required final String university,
    required final bool graduated,
    required final SpecialtyType specialty,
    required final LevelType level,
    required final int experience,
    final String workHistory,
    final List<String> languages,
    final List<String> technologies,
    final int score,
  }) = _$ApplicantImpl;

  factory _Applicant.fromJson(Map<String, dynamic> json) =
      _$ApplicantImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  DateTime get dateOfBirth;
  @override
  EducationType get education;
  @override
  String get university;
  @override
  bool get graduated;
  @override
  SpecialtyType get specialty;
  @override
  LevelType get level;
  @override
  int get experience;
  @override
  String get workHistory;
  @override
  List<String> get languages;
  @override
  List<String> get technologies;
  @override
  int get score;

  /// Create a copy of Applicant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplicantImplCopyWith<_$ApplicantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RequestForApplicant _$RequestForApplicantFromJson(Map<String, dynamic> json) {
  return _RequestForApplicant.fromJson(json);
}

/// @nodoc
mixin _$RequestForApplicant {
  int? get experience => throw _privateConstructorUsedError;
  LevelType? get level => throw _privateConstructorUsedError;
  bool? get graduated => throw _privateConstructorUsedError;
  EducationType? get education => throw _privateConstructorUsedError;
  SpecialtyType? get specialty => throw _privateConstructorUsedError;
  List<String> get languagesRequired => throw _privateConstructorUsedError;
  List<String> get languagesOptional => throw _privateConstructorUsedError;
  List<String> get technologiesRequired => throw _privateConstructorUsedError;
  List<String> get technologiesOptional => throw _privateConstructorUsedError;

  /// Serializes this RequestForApplicant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequestForApplicant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequestForApplicantCopyWith<RequestForApplicant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestForApplicantCopyWith<$Res> {
  factory $RequestForApplicantCopyWith(
    RequestForApplicant value,
    $Res Function(RequestForApplicant) then,
  ) = _$RequestForApplicantCopyWithImpl<$Res, RequestForApplicant>;
  @useResult
  $Res call({
    int? experience,
    LevelType? level,
    bool? graduated,
    EducationType? education,
    SpecialtyType? specialty,
    List<String> languagesRequired,
    List<String> languagesOptional,
    List<String> technologiesRequired,
    List<String> technologiesOptional,
  });
}

/// @nodoc
class _$RequestForApplicantCopyWithImpl<$Res, $Val extends RequestForApplicant>
    implements $RequestForApplicantCopyWith<$Res> {
  _$RequestForApplicantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestForApplicant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? experience = freezed,
    Object? level = freezed,
    Object? graduated = freezed,
    Object? education = freezed,
    Object? specialty = freezed,
    Object? languagesRequired = null,
    Object? languagesOptional = null,
    Object? technologiesRequired = null,
    Object? technologiesOptional = null,
  }) {
    return _then(
      _value.copyWith(
            experience: freezed == experience
                ? _value.experience
                : experience // ignore: cast_nullable_to_non_nullable
                      as int?,
            level: freezed == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as LevelType?,
            graduated: freezed == graduated
                ? _value.graduated
                : graduated // ignore: cast_nullable_to_non_nullable
                      as bool?,
            education: freezed == education
                ? _value.education
                : education // ignore: cast_nullable_to_non_nullable
                      as EducationType?,
            specialty: freezed == specialty
                ? _value.specialty
                : specialty // ignore: cast_nullable_to_non_nullable
                      as SpecialtyType?,
            languagesRequired: null == languagesRequired
                ? _value.languagesRequired
                : languagesRequired // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            languagesOptional: null == languagesOptional
                ? _value.languagesOptional
                : languagesOptional // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            technologiesRequired: null == technologiesRequired
                ? _value.technologiesRequired
                : technologiesRequired // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            technologiesOptional: null == technologiesOptional
                ? _value.technologiesOptional
                : technologiesOptional // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RequestForApplicantImplCopyWith<$Res>
    implements $RequestForApplicantCopyWith<$Res> {
  factory _$$RequestForApplicantImplCopyWith(
    _$RequestForApplicantImpl value,
    $Res Function(_$RequestForApplicantImpl) then,
  ) = __$$RequestForApplicantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? experience,
    LevelType? level,
    bool? graduated,
    EducationType? education,
    SpecialtyType? specialty,
    List<String> languagesRequired,
    List<String> languagesOptional,
    List<String> technologiesRequired,
    List<String> technologiesOptional,
  });
}

/// @nodoc
class __$$RequestForApplicantImplCopyWithImpl<$Res>
    extends _$RequestForApplicantCopyWithImpl<$Res, _$RequestForApplicantImpl>
    implements _$$RequestForApplicantImplCopyWith<$Res> {
  __$$RequestForApplicantImplCopyWithImpl(
    _$RequestForApplicantImpl _value,
    $Res Function(_$RequestForApplicantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestForApplicant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? experience = freezed,
    Object? level = freezed,
    Object? graduated = freezed,
    Object? education = freezed,
    Object? specialty = freezed,
    Object? languagesRequired = null,
    Object? languagesOptional = null,
    Object? technologiesRequired = null,
    Object? technologiesOptional = null,
  }) {
    return _then(
      _$RequestForApplicantImpl(
        experience: freezed == experience
            ? _value.experience
            : experience // ignore: cast_nullable_to_non_nullable
                  as int?,
        level: freezed == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as LevelType?,
        graduated: freezed == graduated
            ? _value.graduated
            : graduated // ignore: cast_nullable_to_non_nullable
                  as bool?,
        education: freezed == education
            ? _value.education
            : education // ignore: cast_nullable_to_non_nullable
                  as EducationType?,
        specialty: freezed == specialty
            ? _value.specialty
            : specialty // ignore: cast_nullable_to_non_nullable
                  as SpecialtyType?,
        languagesRequired: null == languagesRequired
            ? _value._languagesRequired
            : languagesRequired // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        languagesOptional: null == languagesOptional
            ? _value._languagesOptional
            : languagesOptional // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        technologiesRequired: null == technologiesRequired
            ? _value._technologiesRequired
            : technologiesRequired // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        technologiesOptional: null == technologiesOptional
            ? _value._technologiesOptional
            : technologiesOptional // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$RequestForApplicantImpl implements _RequestForApplicant {
  const _$RequestForApplicantImpl({
    this.experience,
    this.level,
    this.graduated,
    this.education,
    this.specialty,
    final List<String> languagesRequired = const [],
    final List<String> languagesOptional = const [],
    final List<String> technologiesRequired = const [],
    final List<String> technologiesOptional = const [],
  }) : _languagesRequired = languagesRequired,
       _languagesOptional = languagesOptional,
       _technologiesRequired = technologiesRequired,
       _technologiesOptional = technologiesOptional;

  factory _$RequestForApplicantImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestForApplicantImplFromJson(json);

  @override
  final int? experience;
  @override
  final LevelType? level;
  @override
  final bool? graduated;
  @override
  final EducationType? education;
  @override
  final SpecialtyType? specialty;
  final List<String> _languagesRequired;
  @override
  @JsonKey()
  List<String> get languagesRequired {
    if (_languagesRequired is EqualUnmodifiableListView)
      return _languagesRequired;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languagesRequired);
  }

  final List<String> _languagesOptional;
  @override
  @JsonKey()
  List<String> get languagesOptional {
    if (_languagesOptional is EqualUnmodifiableListView)
      return _languagesOptional;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languagesOptional);
  }

  final List<String> _technologiesRequired;
  @override
  @JsonKey()
  List<String> get technologiesRequired {
    if (_technologiesRequired is EqualUnmodifiableListView)
      return _technologiesRequired;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_technologiesRequired);
  }

  final List<String> _technologiesOptional;
  @override
  @JsonKey()
  List<String> get technologiesOptional {
    if (_technologiesOptional is EqualUnmodifiableListView)
      return _technologiesOptional;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_technologiesOptional);
  }

  @override
  String toString() {
    return 'RequestForApplicant(experience: $experience, level: $level, graduated: $graduated, education: $education, specialty: $specialty, languagesRequired: $languagesRequired, languagesOptional: $languagesOptional, technologiesRequired: $technologiesRequired, technologiesOptional: $technologiesOptional)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestForApplicantImpl &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.graduated, graduated) ||
                other.graduated == graduated) &&
            (identical(other.education, education) ||
                other.education == education) &&
            (identical(other.specialty, specialty) ||
                other.specialty == specialty) &&
            const DeepCollectionEquality().equals(
              other._languagesRequired,
              _languagesRequired,
            ) &&
            const DeepCollectionEquality().equals(
              other._languagesOptional,
              _languagesOptional,
            ) &&
            const DeepCollectionEquality().equals(
              other._technologiesRequired,
              _technologiesRequired,
            ) &&
            const DeepCollectionEquality().equals(
              other._technologiesOptional,
              _technologiesOptional,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    experience,
    level,
    graduated,
    education,
    specialty,
    const DeepCollectionEquality().hash(_languagesRequired),
    const DeepCollectionEquality().hash(_languagesOptional),
    const DeepCollectionEquality().hash(_technologiesRequired),
    const DeepCollectionEquality().hash(_technologiesOptional),
  );

  /// Create a copy of RequestForApplicant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestForApplicantImplCopyWith<_$RequestForApplicantImpl> get copyWith =>
      __$$RequestForApplicantImplCopyWithImpl<_$RequestForApplicantImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestForApplicantImplToJson(this);
  }
}

abstract class _RequestForApplicant implements RequestForApplicant {
  const factory _RequestForApplicant({
    final int? experience,
    final LevelType? level,
    final bool? graduated,
    final EducationType? education,
    final SpecialtyType? specialty,
    final List<String> languagesRequired,
    final List<String> languagesOptional,
    final List<String> technologiesRequired,
    final List<String> technologiesOptional,
  }) = _$RequestForApplicantImpl;

  factory _RequestForApplicant.fromJson(Map<String, dynamic> json) =
      _$RequestForApplicantImpl.fromJson;

  @override
  int? get experience;
  @override
  LevelType? get level;
  @override
  bool? get graduated;
  @override
  EducationType? get education;
  @override
  SpecialtyType? get specialty;
  @override
  List<String> get languagesRequired;
  @override
  List<String> get languagesOptional;
  @override
  List<String> get technologiesRequired;
  @override
  List<String> get technologiesOptional;

  /// Create a copy of RequestForApplicant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestForApplicantImplCopyWith<_$RequestForApplicantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
