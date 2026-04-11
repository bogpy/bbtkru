// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Company {

 int get id; String get name; String get country; int get yearFound; int get employeeCount; List<Vacancy> get vacancies; int get score;
/// Create a copy of Company
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyCopyWith<Company> get copyWith => _$CompanyCopyWithImpl<Company>(this as Company, _$identity);

  /// Serializes this Company to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Company&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.yearFound, yearFound) || other.yearFound == yearFound)&&(identical(other.employeeCount, employeeCount) || other.employeeCount == employeeCount)&&const DeepCollectionEquality().equals(other.vacancies, vacancies)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,country,yearFound,employeeCount,const DeepCollectionEquality().hash(vacancies),score);

@override
String toString() {
  return 'Company(id: $id, name: $name, country: $country, yearFound: $yearFound, employeeCount: $employeeCount, vacancies: $vacancies, score: $score)';
}


}

/// @nodoc
abstract mixin class $CompanyCopyWith<$Res>  {
  factory $CompanyCopyWith(Company value, $Res Function(Company) _then) = _$CompanyCopyWithImpl;
@useResult
$Res call({
 int id, String name, String country, int yearFound, int employeeCount, List<Vacancy> vacancies, int score
});




}
/// @nodoc
class _$CompanyCopyWithImpl<$Res>
    implements $CompanyCopyWith<$Res> {
  _$CompanyCopyWithImpl(this._self, this._then);

  final Company _self;
  final $Res Function(Company) _then;

/// Create a copy of Company
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? country = null,Object? yearFound = null,Object? employeeCount = null,Object? vacancies = null,Object? score = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,yearFound: null == yearFound ? _self.yearFound : yearFound // ignore: cast_nullable_to_non_nullable
as int,employeeCount: null == employeeCount ? _self.employeeCount : employeeCount // ignore: cast_nullable_to_non_nullable
as int,vacancies: null == vacancies ? _self.vacancies : vacancies // ignore: cast_nullable_to_non_nullable
as List<Vacancy>,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Company].
extension CompanyPatterns on Company {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Company value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Company() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Company value)  $default,){
final _that = this;
switch (_that) {
case _Company():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Company value)?  $default,){
final _that = this;
switch (_that) {
case _Company() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String country,  int yearFound,  int employeeCount,  List<Vacancy> vacancies,  int score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Company() when $default != null:
return $default(_that.id,_that.name,_that.country,_that.yearFound,_that.employeeCount,_that.vacancies,_that.score);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String country,  int yearFound,  int employeeCount,  List<Vacancy> vacancies,  int score)  $default,) {final _that = this;
switch (_that) {
case _Company():
return $default(_that.id,_that.name,_that.country,_that.yearFound,_that.employeeCount,_that.vacancies,_that.score);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String country,  int yearFound,  int employeeCount,  List<Vacancy> vacancies,  int score)?  $default,) {final _that = this;
switch (_that) {
case _Company() when $default != null:
return $default(_that.id,_that.name,_that.country,_that.yearFound,_that.employeeCount,_that.vacancies,_that.score);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Company implements Company {
  const _Company({required this.id, required this.name, required this.country, required this.yearFound, required this.employeeCount, final  List<Vacancy> vacancies = const [], this.score = 0}): _vacancies = vacancies;
  factory _Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);

@override final  int id;
@override final  String name;
@override final  String country;
@override final  int yearFound;
@override final  int employeeCount;
 final  List<Vacancy> _vacancies;
@override@JsonKey() List<Vacancy> get vacancies {
  if (_vacancies is EqualUnmodifiableListView) return _vacancies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vacancies);
}

@override@JsonKey() final  int score;

/// Create a copy of Company
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyCopyWith<_Company> get copyWith => __$CompanyCopyWithImpl<_Company>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompanyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Company&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.yearFound, yearFound) || other.yearFound == yearFound)&&(identical(other.employeeCount, employeeCount) || other.employeeCount == employeeCount)&&const DeepCollectionEquality().equals(other._vacancies, _vacancies)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,country,yearFound,employeeCount,const DeepCollectionEquality().hash(_vacancies),score);

@override
String toString() {
  return 'Company(id: $id, name: $name, country: $country, yearFound: $yearFound, employeeCount: $employeeCount, vacancies: $vacancies, score: $score)';
}


}

/// @nodoc
abstract mixin class _$CompanyCopyWith<$Res> implements $CompanyCopyWith<$Res> {
  factory _$CompanyCopyWith(_Company value, $Res Function(_Company) _then) = __$CompanyCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String country, int yearFound, int employeeCount, List<Vacancy> vacancies, int score
});




}
/// @nodoc
class __$CompanyCopyWithImpl<$Res>
    implements _$CompanyCopyWith<$Res> {
  __$CompanyCopyWithImpl(this._self, this._then);

  final _Company _self;
  final $Res Function(_Company) _then;

/// Create a copy of Company
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? country = null,Object? yearFound = null,Object? employeeCount = null,Object? vacancies = null,Object? score = null,}) {
  return _then(_Company(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,yearFound: null == yearFound ? _self.yearFound : yearFound // ignore: cast_nullable_to_non_nullable
as int,employeeCount: null == employeeCount ? _self.employeeCount : employeeCount // ignore: cast_nullable_to_non_nullable
as int,vacancies: null == vacancies ? _self._vacancies : vacancies // ignore: cast_nullable_to_non_nullable
as List<Vacancy>,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RequestForCompany {

 String? get country; int? get employeeCount;
/// Create a copy of RequestForCompany
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestForCompanyCopyWith<RequestForCompany> get copyWith => _$RequestForCompanyCopyWithImpl<RequestForCompany>(this as RequestForCompany, _$identity);

  /// Serializes this RequestForCompany to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestForCompany&&(identical(other.country, country) || other.country == country)&&(identical(other.employeeCount, employeeCount) || other.employeeCount == employeeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,country,employeeCount);

@override
String toString() {
  return 'RequestForCompany(country: $country, employeeCount: $employeeCount)';
}


}

/// @nodoc
abstract mixin class $RequestForCompanyCopyWith<$Res>  {
  factory $RequestForCompanyCopyWith(RequestForCompany value, $Res Function(RequestForCompany) _then) = _$RequestForCompanyCopyWithImpl;
@useResult
$Res call({
 String? country, int? employeeCount
});




}
/// @nodoc
class _$RequestForCompanyCopyWithImpl<$Res>
    implements $RequestForCompanyCopyWith<$Res> {
  _$RequestForCompanyCopyWithImpl(this._self, this._then);

  final RequestForCompany _self;
  final $Res Function(RequestForCompany) _then;

/// Create a copy of RequestForCompany
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? country = freezed,Object? employeeCount = freezed,}) {
  return _then(_self.copyWith(
country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,employeeCount: freezed == employeeCount ? _self.employeeCount : employeeCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RequestForCompany].
extension RequestForCompanyPatterns on RequestForCompany {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestForCompany value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestForCompany() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestForCompany value)  $default,){
final _that = this;
switch (_that) {
case _RequestForCompany():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestForCompany value)?  $default,){
final _that = this;
switch (_that) {
case _RequestForCompany() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? country,  int? employeeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestForCompany() when $default != null:
return $default(_that.country,_that.employeeCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? country,  int? employeeCount)  $default,) {final _that = this;
switch (_that) {
case _RequestForCompany():
return $default(_that.country,_that.employeeCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? country,  int? employeeCount)?  $default,) {final _that = this;
switch (_that) {
case _RequestForCompany() when $default != null:
return $default(_that.country,_that.employeeCount);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _RequestForCompany implements RequestForCompany {
  const _RequestForCompany({this.country, this.employeeCount});
  factory _RequestForCompany.fromJson(Map<String, dynamic> json) => _$RequestForCompanyFromJson(json);

@override final  String? country;
@override final  int? employeeCount;

/// Create a copy of RequestForCompany
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestForCompanyCopyWith<_RequestForCompany> get copyWith => __$RequestForCompanyCopyWithImpl<_RequestForCompany>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestForCompanyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestForCompany&&(identical(other.country, country) || other.country == country)&&(identical(other.employeeCount, employeeCount) || other.employeeCount == employeeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,country,employeeCount);

@override
String toString() {
  return 'RequestForCompany(country: $country, employeeCount: $employeeCount)';
}


}

/// @nodoc
abstract mixin class _$RequestForCompanyCopyWith<$Res> implements $RequestForCompanyCopyWith<$Res> {
  factory _$RequestForCompanyCopyWith(_RequestForCompany value, $Res Function(_RequestForCompany) _then) = __$RequestForCompanyCopyWithImpl;
@override @useResult
$Res call({
 String? country, int? employeeCount
});




}
/// @nodoc
class __$RequestForCompanyCopyWithImpl<$Res>
    implements _$RequestForCompanyCopyWith<$Res> {
  __$RequestForCompanyCopyWithImpl(this._self, this._then);

  final _RequestForCompany _self;
  final $Res Function(_RequestForCompany) _then;

/// Create a copy of RequestForCompany
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? country = freezed,Object? employeeCount = freezed,}) {
  return _then(_RequestForCompany(
country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,employeeCount: freezed == employeeCount ? _self.employeeCount : employeeCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
