// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return _Company.fromJson(json);
}

/// @nodoc
mixin _$Company {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  int get yearFound => throw _privateConstructorUsedError;
  int get employeeCount => throw _privateConstructorUsedError;
  List<Vacancy> get vacancies => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;

  /// Serializes this Company to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Company
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompanyCopyWith<Company> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyCopyWith<$Res> {
  factory $CompanyCopyWith(Company value, $Res Function(Company) then) =
      _$CompanyCopyWithImpl<$Res, Company>;
  @useResult
  $Res call({
    int id,
    String name,
    String country,
    int yearFound,
    int employeeCount,
    List<Vacancy> vacancies,
    int score,
  });
}

/// @nodoc
class _$CompanyCopyWithImpl<$Res, $Val extends Company>
    implements $CompanyCopyWith<$Res> {
  _$CompanyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Company
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? country = null,
    Object? yearFound = null,
    Object? employeeCount = null,
    Object? vacancies = null,
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
            country: null == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String,
            yearFound: null == yearFound
                ? _value.yearFound
                : yearFound // ignore: cast_nullable_to_non_nullable
                      as int,
            employeeCount: null == employeeCount
                ? _value.employeeCount
                : employeeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            vacancies: null == vacancies
                ? _value.vacancies
                : vacancies // ignore: cast_nullable_to_non_nullable
                      as List<Vacancy>,
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
abstract class _$$CompanyImplCopyWith<$Res> implements $CompanyCopyWith<$Res> {
  factory _$$CompanyImplCopyWith(
    _$CompanyImpl value,
    $Res Function(_$CompanyImpl) then,
  ) = __$$CompanyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String country,
    int yearFound,
    int employeeCount,
    List<Vacancy> vacancies,
    int score,
  });
}

/// @nodoc
class __$$CompanyImplCopyWithImpl<$Res>
    extends _$CompanyCopyWithImpl<$Res, _$CompanyImpl>
    implements _$$CompanyImplCopyWith<$Res> {
  __$$CompanyImplCopyWithImpl(
    _$CompanyImpl _value,
    $Res Function(_$CompanyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Company
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? country = null,
    Object? yearFound = null,
    Object? employeeCount = null,
    Object? vacancies = null,
    Object? score = null,
  }) {
    return _then(
      _$CompanyImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        country: null == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String,
        yearFound: null == yearFound
            ? _value.yearFound
            : yearFound // ignore: cast_nullable_to_non_nullable
                  as int,
        employeeCount: null == employeeCount
            ? _value.employeeCount
            : employeeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        vacancies: null == vacancies
            ? _value._vacancies
            : vacancies // ignore: cast_nullable_to_non_nullable
                  as List<Vacancy>,
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
class _$CompanyImpl implements _Company {
  const _$CompanyImpl({
    required this.id,
    required this.name,
    required this.country,
    required this.yearFound,
    required this.employeeCount,
    final List<Vacancy> vacancies = const [],
    this.score = 0,
  }) : _vacancies = vacancies;

  factory _$CompanyImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String country;
  @override
  final int yearFound;
  @override
  final int employeeCount;
  final List<Vacancy> _vacancies;
  @override
  @JsonKey()
  List<Vacancy> get vacancies {
    if (_vacancies is EqualUnmodifiableListView) return _vacancies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vacancies);
  }

  @override
  @JsonKey()
  final int score;

  @override
  String toString() {
    return 'Company(id: $id, name: $name, country: $country, yearFound: $yearFound, employeeCount: $employeeCount, vacancies: $vacancies, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.yearFound, yearFound) ||
                other.yearFound == yearFound) &&
            (identical(other.employeeCount, employeeCount) ||
                other.employeeCount == employeeCount) &&
            const DeepCollectionEquality().equals(
              other._vacancies,
              _vacancies,
            ) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    country,
    yearFound,
    employeeCount,
    const DeepCollectionEquality().hash(_vacancies),
    score,
  );

  /// Create a copy of Company
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyImplCopyWith<_$CompanyImpl> get copyWith =>
      __$$CompanyImplCopyWithImpl<_$CompanyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyImplToJson(this);
  }
}

abstract class _Company implements Company {
  const factory _Company({
    required final int id,
    required final String name,
    required final String country,
    required final int yearFound,
    required final int employeeCount,
    final List<Vacancy> vacancies,
    final int score,
  }) = _$CompanyImpl;

  factory _Company.fromJson(Map<String, dynamic> json) = _$CompanyImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get country;
  @override
  int get yearFound;
  @override
  int get employeeCount;
  @override
  List<Vacancy> get vacancies;
  @override
  int get score;

  /// Create a copy of Company
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompanyImplCopyWith<_$CompanyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RequestForCompany _$RequestForCompanyFromJson(Map<String, dynamic> json) {
  return _RequestForCompany.fromJson(json);
}

/// @nodoc
mixin _$RequestForCompany {
  String? get country => throw _privateConstructorUsedError;
  int? get employeeCount => throw _privateConstructorUsedError;

  /// Serializes this RequestForCompany to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequestForCompany
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequestForCompanyCopyWith<RequestForCompany> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestForCompanyCopyWith<$Res> {
  factory $RequestForCompanyCopyWith(
    RequestForCompany value,
    $Res Function(RequestForCompany) then,
  ) = _$RequestForCompanyCopyWithImpl<$Res, RequestForCompany>;
  @useResult
  $Res call({String? country, int? employeeCount});
}

/// @nodoc
class _$RequestForCompanyCopyWithImpl<$Res, $Val extends RequestForCompany>
    implements $RequestForCompanyCopyWith<$Res> {
  _$RequestForCompanyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestForCompany
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? country = freezed, Object? employeeCount = freezed}) {
    return _then(
      _value.copyWith(
            country: freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String?,
            employeeCount: freezed == employeeCount
                ? _value.employeeCount
                : employeeCount // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RequestForCompanyImplCopyWith<$Res>
    implements $RequestForCompanyCopyWith<$Res> {
  factory _$$RequestForCompanyImplCopyWith(
    _$RequestForCompanyImpl value,
    $Res Function(_$RequestForCompanyImpl) then,
  ) = __$$RequestForCompanyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? country, int? employeeCount});
}

/// @nodoc
class __$$RequestForCompanyImplCopyWithImpl<$Res>
    extends _$RequestForCompanyCopyWithImpl<$Res, _$RequestForCompanyImpl>
    implements _$$RequestForCompanyImplCopyWith<$Res> {
  __$$RequestForCompanyImplCopyWithImpl(
    _$RequestForCompanyImpl _value,
    $Res Function(_$RequestForCompanyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestForCompany
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? country = freezed, Object? employeeCount = freezed}) {
    return _then(
      _$RequestForCompanyImpl(
        country: freezed == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String?,
        employeeCount: freezed == employeeCount
            ? _value.employeeCount
            : employeeCount // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestForCompanyImpl implements _RequestForCompany {
  const _$RequestForCompanyImpl({this.country, this.employeeCount});

  factory _$RequestForCompanyImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestForCompanyImplFromJson(json);

  @override
  final String? country;
  @override
  final int? employeeCount;

  @override
  String toString() {
    return 'RequestForCompany(country: $country, employeeCount: $employeeCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestForCompanyImpl &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.employeeCount, employeeCount) ||
                other.employeeCount == employeeCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, country, employeeCount);

  /// Create a copy of RequestForCompany
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestForCompanyImplCopyWith<_$RequestForCompanyImpl> get copyWith =>
      __$$RequestForCompanyImplCopyWithImpl<_$RequestForCompanyImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestForCompanyImplToJson(this);
  }
}

abstract class _RequestForCompany implements RequestForCompany {
  const factory _RequestForCompany({
    final String? country,
    final int? employeeCount,
  }) = _$RequestForCompanyImpl;

  factory _RequestForCompany.fromJson(Map<String, dynamic> json) =
      _$RequestForCompanyImpl.fromJson;

  @override
  String? get country;
  @override
  int? get employeeCount;

  /// Create a copy of RequestForCompany
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestForCompanyImplCopyWith<_$RequestForCompanyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
