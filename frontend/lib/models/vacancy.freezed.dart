// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vacancy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Vacancy {

 int get id; String get title; String get description; int get companyID; String get companyName; int get experience; int get salary; int get hours; EmploymentType get employment; LocationType get location; List<String> get languages; List<String> get technologies; int get score;
/// Create a copy of Vacancy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VacancyCopyWith<Vacancy> get copyWith => _$VacancyCopyWithImpl<Vacancy>(this as Vacancy, _$identity);

  /// Serializes this Vacancy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Vacancy&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.companyID, companyID) || other.companyID == companyID)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.employment, employment) || other.employment == employment)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.languages, languages)&&const DeepCollectionEquality().equals(other.technologies, technologies)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,companyID,companyName,experience,salary,hours,employment,location,const DeepCollectionEquality().hash(languages),const DeepCollectionEquality().hash(technologies),score);

@override
String toString() {
  return 'Vacancy(id: $id, title: $title, description: $description, companyID: $companyID, companyName: $companyName, experience: $experience, salary: $salary, hours: $hours, employment: $employment, location: $location, languages: $languages, technologies: $technologies, score: $score)';
}


}

/// @nodoc
abstract mixin class $VacancyCopyWith<$Res>  {
  factory $VacancyCopyWith(Vacancy value, $Res Function(Vacancy) _then) = _$VacancyCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description, int companyID, String companyName, int experience, int salary, int hours, EmploymentType employment, LocationType location, List<String> languages, List<String> technologies, int score
});




}
/// @nodoc
class _$VacancyCopyWithImpl<$Res>
    implements $VacancyCopyWith<$Res> {
  _$VacancyCopyWithImpl(this._self, this._then);

  final Vacancy _self;
  final $Res Function(Vacancy) _then;

/// Create a copy of Vacancy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? companyID = null,Object? companyName = null,Object? experience = null,Object? salary = null,Object? hours = null,Object? employment = null,Object? location = null,Object? languages = null,Object? technologies = null,Object? score = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,companyID: null == companyID ? _self.companyID : companyID // ignore: cast_nullable_to_non_nullable
as int,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,experience: null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as int,salary: null == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as int,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as int,employment: null == employment ? _self.employment : employment // ignore: cast_nullable_to_non_nullable
as EmploymentType,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationType,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,technologies: null == technologies ? _self.technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Vacancy].
extension VacancyPatterns on Vacancy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Vacancy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Vacancy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Vacancy value)  $default,){
final _that = this;
switch (_that) {
case _Vacancy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Vacancy value)?  $default,){
final _that = this;
switch (_that) {
case _Vacancy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String description,  int companyID,  String companyName,  int experience,  int salary,  int hours,  EmploymentType employment,  LocationType location,  List<String> languages,  List<String> technologies,  int score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Vacancy() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.companyID,_that.companyName,_that.experience,_that.salary,_that.hours,_that.employment,_that.location,_that.languages,_that.technologies,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String description,  int companyID,  String companyName,  int experience,  int salary,  int hours,  EmploymentType employment,  LocationType location,  List<String> languages,  List<String> technologies,  int score)  $default,) {final _that = this;
switch (_that) {
case _Vacancy():
return $default(_that.id,_that.title,_that.description,_that.companyID,_that.companyName,_that.experience,_that.salary,_that.hours,_that.employment,_that.location,_that.languages,_that.technologies,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String description,  int companyID,  String companyName,  int experience,  int salary,  int hours,  EmploymentType employment,  LocationType location,  List<String> languages,  List<String> technologies,  int score)?  $default,) {final _that = this;
switch (_that) {
case _Vacancy() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.companyID,_that.companyName,_that.experience,_that.salary,_that.hours,_that.employment,_that.location,_that.languages,_that.technologies,_that.score);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Vacancy implements Vacancy {
  const _Vacancy({required this.id, required this.title, required this.description, required this.companyID, required this.companyName, required this.experience, required this.salary, required this.hours, required this.employment, required this.location, final  List<String> languages = const [], final  List<String> technologies = const [], this.score = 0}): _languages = languages,_technologies = technologies;
  factory _Vacancy.fromJson(Map<String, dynamic> json) => _$VacancyFromJson(json);

@override final  int id;
@override final  String title;
@override final  String description;
@override final  int companyID;
@override final  String companyName;
@override final  int experience;
@override final  int salary;
@override final  int hours;
@override final  EmploymentType employment;
@override final  LocationType location;
 final  List<String> _languages;
@override@JsonKey() List<String> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}

 final  List<String> _technologies;
@override@JsonKey() List<String> get technologies {
  if (_technologies is EqualUnmodifiableListView) return _technologies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_technologies);
}

@override@JsonKey() final  int score;

/// Create a copy of Vacancy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VacancyCopyWith<_Vacancy> get copyWith => __$VacancyCopyWithImpl<_Vacancy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VacancyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Vacancy&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.companyID, companyID) || other.companyID == companyID)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.employment, employment) || other.employment == employment)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._languages, _languages)&&const DeepCollectionEquality().equals(other._technologies, _technologies)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,companyID,companyName,experience,salary,hours,employment,location,const DeepCollectionEquality().hash(_languages),const DeepCollectionEquality().hash(_technologies),score);

@override
String toString() {
  return 'Vacancy(id: $id, title: $title, description: $description, companyID: $companyID, companyName: $companyName, experience: $experience, salary: $salary, hours: $hours, employment: $employment, location: $location, languages: $languages, technologies: $technologies, score: $score)';
}


}

/// @nodoc
abstract mixin class _$VacancyCopyWith<$Res> implements $VacancyCopyWith<$Res> {
  factory _$VacancyCopyWith(_Vacancy value, $Res Function(_Vacancy) _then) = __$VacancyCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description, int companyID, String companyName, int experience, int salary, int hours, EmploymentType employment, LocationType location, List<String> languages, List<String> technologies, int score
});




}
/// @nodoc
class __$VacancyCopyWithImpl<$Res>
    implements _$VacancyCopyWith<$Res> {
  __$VacancyCopyWithImpl(this._self, this._then);

  final _Vacancy _self;
  final $Res Function(_Vacancy) _then;

/// Create a copy of Vacancy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? companyID = null,Object? companyName = null,Object? experience = null,Object? salary = null,Object? hours = null,Object? employment = null,Object? location = null,Object? languages = null,Object? technologies = null,Object? score = null,}) {
  return _then(_Vacancy(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,companyID: null == companyID ? _self.companyID : companyID // ignore: cast_nullable_to_non_nullable
as int,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,experience: null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as int,salary: null == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as int,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as int,employment: null == employment ? _self.employment : employment // ignore: cast_nullable_to_non_nullable
as EmploymentType,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationType,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,technologies: null == technologies ? _self._technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RequestForVacancy {

 int? get experience; int? get salary; EmploymentType? get employment; LocationType? get location; String? get country; int? get hours; List<String> get languages; List<String> get technologies;
/// Create a copy of RequestForVacancy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestForVacancyCopyWith<RequestForVacancy> get copyWith => _$RequestForVacancyCopyWithImpl<RequestForVacancy>(this as RequestForVacancy, _$identity);

  /// Serializes this RequestForVacancy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestForVacancy&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.employment, employment) || other.employment == employment)&&(identical(other.location, location) || other.location == location)&&(identical(other.country, country) || other.country == country)&&(identical(other.hours, hours) || other.hours == hours)&&const DeepCollectionEquality().equals(other.languages, languages)&&const DeepCollectionEquality().equals(other.technologies, technologies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,experience,salary,employment,location,country,hours,const DeepCollectionEquality().hash(languages),const DeepCollectionEquality().hash(technologies));

@override
String toString() {
  return 'RequestForVacancy(experience: $experience, salary: $salary, employment: $employment, location: $location, country: $country, hours: $hours, languages: $languages, technologies: $technologies)';
}


}

/// @nodoc
abstract mixin class $RequestForVacancyCopyWith<$Res>  {
  factory $RequestForVacancyCopyWith(RequestForVacancy value, $Res Function(RequestForVacancy) _then) = _$RequestForVacancyCopyWithImpl;
@useResult
$Res call({
 int? experience, int? salary, EmploymentType? employment, LocationType? location, String? country, int? hours, List<String> languages, List<String> technologies
});




}
/// @nodoc
class _$RequestForVacancyCopyWithImpl<$Res>
    implements $RequestForVacancyCopyWith<$Res> {
  _$RequestForVacancyCopyWithImpl(this._self, this._then);

  final RequestForVacancy _self;
  final $Res Function(RequestForVacancy) _then;

/// Create a copy of RequestForVacancy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? experience = freezed,Object? salary = freezed,Object? employment = freezed,Object? location = freezed,Object? country = freezed,Object? hours = freezed,Object? languages = null,Object? technologies = null,}) {
  return _then(_self.copyWith(
experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as int?,salary: freezed == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as int?,employment: freezed == employment ? _self.employment : employment // ignore: cast_nullable_to_non_nullable
as EmploymentType?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationType?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,hours: freezed == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as int?,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,technologies: null == technologies ? _self.technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [RequestForVacancy].
extension RequestForVacancyPatterns on RequestForVacancy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestForVacancy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestForVacancy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestForVacancy value)  $default,){
final _that = this;
switch (_that) {
case _RequestForVacancy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestForVacancy value)?  $default,){
final _that = this;
switch (_that) {
case _RequestForVacancy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? experience,  int? salary,  EmploymentType? employment,  LocationType? location,  String? country,  int? hours,  List<String> languages,  List<String> technologies)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestForVacancy() when $default != null:
return $default(_that.experience,_that.salary,_that.employment,_that.location,_that.country,_that.hours,_that.languages,_that.technologies);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? experience,  int? salary,  EmploymentType? employment,  LocationType? location,  String? country,  int? hours,  List<String> languages,  List<String> technologies)  $default,) {final _that = this;
switch (_that) {
case _RequestForVacancy():
return $default(_that.experience,_that.salary,_that.employment,_that.location,_that.country,_that.hours,_that.languages,_that.technologies);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? experience,  int? salary,  EmploymentType? employment,  LocationType? location,  String? country,  int? hours,  List<String> languages,  List<String> technologies)?  $default,) {final _that = this;
switch (_that) {
case _RequestForVacancy() when $default != null:
return $default(_that.experience,_that.salary,_that.employment,_that.location,_that.country,_that.hours,_that.languages,_that.technologies);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _RequestForVacancy implements RequestForVacancy {
  const _RequestForVacancy({this.experience, this.salary, this.employment, this.location, this.country, this.hours, final  List<String> languages = const [], final  List<String> technologies = const []}): _languages = languages,_technologies = technologies;
  factory _RequestForVacancy.fromJson(Map<String, dynamic> json) => _$RequestForVacancyFromJson(json);

@override final  int? experience;
@override final  int? salary;
@override final  EmploymentType? employment;
@override final  LocationType? location;
@override final  String? country;
@override final  int? hours;
 final  List<String> _languages;
@override@JsonKey() List<String> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}

 final  List<String> _technologies;
@override@JsonKey() List<String> get technologies {
  if (_technologies is EqualUnmodifiableListView) return _technologies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_technologies);
}


/// Create a copy of RequestForVacancy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestForVacancyCopyWith<_RequestForVacancy> get copyWith => __$RequestForVacancyCopyWithImpl<_RequestForVacancy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestForVacancyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestForVacancy&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.employment, employment) || other.employment == employment)&&(identical(other.location, location) || other.location == location)&&(identical(other.country, country) || other.country == country)&&(identical(other.hours, hours) || other.hours == hours)&&const DeepCollectionEquality().equals(other._languages, _languages)&&const DeepCollectionEquality().equals(other._technologies, _technologies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,experience,salary,employment,location,country,hours,const DeepCollectionEquality().hash(_languages),const DeepCollectionEquality().hash(_technologies));

@override
String toString() {
  return 'RequestForVacancy(experience: $experience, salary: $salary, employment: $employment, location: $location, country: $country, hours: $hours, languages: $languages, technologies: $technologies)';
}


}

/// @nodoc
abstract mixin class _$RequestForVacancyCopyWith<$Res> implements $RequestForVacancyCopyWith<$Res> {
  factory _$RequestForVacancyCopyWith(_RequestForVacancy value, $Res Function(_RequestForVacancy) _then) = __$RequestForVacancyCopyWithImpl;
@override @useResult
$Res call({
 int? experience, int? salary, EmploymentType? employment, LocationType? location, String? country, int? hours, List<String> languages, List<String> technologies
});




}
/// @nodoc
class __$RequestForVacancyCopyWithImpl<$Res>
    implements _$RequestForVacancyCopyWith<$Res> {
  __$RequestForVacancyCopyWithImpl(this._self, this._then);

  final _RequestForVacancy _self;
  final $Res Function(_RequestForVacancy) _then;

/// Create a copy of RequestForVacancy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? experience = freezed,Object? salary = freezed,Object? employment = freezed,Object? location = freezed,Object? country = freezed,Object? hours = freezed,Object? languages = null,Object? technologies = null,}) {
  return _then(_RequestForVacancy(
experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as int?,salary: freezed == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as int?,employment: freezed == employment ? _self.employment : employment // ignore: cast_nullable_to_non_nullable
as EmploymentType?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationType?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,hours: freezed == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as int?,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,technologies: null == technologies ? _self._technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
