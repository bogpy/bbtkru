// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'applicant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Applicant {

 int get id; String get name; DateTime get dateOfBirth; EducationType get education; String get university; bool get graduated; SpecialtyType get specialty; LevelType get level; int get experience; String get workHistory; List<String> get languages; List<String> get technologies; int get score;
/// Create a copy of Applicant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicantCopyWith<Applicant> get copyWith => _$ApplicantCopyWithImpl<Applicant>(this as Applicant, _$identity);

  /// Serializes this Applicant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Applicant&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.education, education) || other.education == education)&&(identical(other.university, university) || other.university == university)&&(identical(other.graduated, graduated) || other.graduated == graduated)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&(identical(other.level, level) || other.level == level)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.workHistory, workHistory) || other.workHistory == workHistory)&&const DeepCollectionEquality().equals(other.languages, languages)&&const DeepCollectionEquality().equals(other.technologies, technologies)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,dateOfBirth,education,university,graduated,specialty,level,experience,workHistory,const DeepCollectionEquality().hash(languages),const DeepCollectionEquality().hash(technologies),score);

@override
String toString() {
  return 'Applicant(id: $id, name: $name, dateOfBirth: $dateOfBirth, education: $education, university: $university, graduated: $graduated, specialty: $specialty, level: $level, experience: $experience, workHistory: $workHistory, languages: $languages, technologies: $technologies, score: $score)';
}


}

/// @nodoc
abstract mixin class $ApplicantCopyWith<$Res>  {
  factory $ApplicantCopyWith(Applicant value, $Res Function(Applicant) _then) = _$ApplicantCopyWithImpl;
@useResult
$Res call({
 int id, String name, DateTime dateOfBirth, EducationType education, String university, bool graduated, SpecialtyType specialty, LevelType level, int experience, String workHistory, List<String> languages, List<String> technologies, int score
});




}
/// @nodoc
class _$ApplicantCopyWithImpl<$Res>
    implements $ApplicantCopyWith<$Res> {
  _$ApplicantCopyWithImpl(this._self, this._then);

  final Applicant _self;
  final $Res Function(Applicant) _then;

/// Create a copy of Applicant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? dateOfBirth = null,Object? education = null,Object? university = null,Object? graduated = null,Object? specialty = null,Object? level = null,Object? experience = null,Object? workHistory = null,Object? languages = null,Object? technologies = null,Object? score = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: null == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime,education: null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as EducationType,university: null == university ? _self.university : university // ignore: cast_nullable_to_non_nullable
as String,graduated: null == graduated ? _self.graduated : graduated // ignore: cast_nullable_to_non_nullable
as bool,specialty: null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as SpecialtyType,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as LevelType,experience: null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as int,workHistory: null == workHistory ? _self.workHistory : workHistory // ignore: cast_nullable_to_non_nullable
as String,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,technologies: null == technologies ? _self.technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Applicant].
extension ApplicantPatterns on Applicant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Applicant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Applicant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Applicant value)  $default,){
final _that = this;
switch (_that) {
case _Applicant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Applicant value)?  $default,){
final _that = this;
switch (_that) {
case _Applicant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  DateTime dateOfBirth,  EducationType education,  String university,  bool graduated,  SpecialtyType specialty,  LevelType level,  int experience,  String workHistory,  List<String> languages,  List<String> technologies,  int score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Applicant() when $default != null:
return $default(_that.id,_that.name,_that.dateOfBirth,_that.education,_that.university,_that.graduated,_that.specialty,_that.level,_that.experience,_that.workHistory,_that.languages,_that.technologies,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  DateTime dateOfBirth,  EducationType education,  String university,  bool graduated,  SpecialtyType specialty,  LevelType level,  int experience,  String workHistory,  List<String> languages,  List<String> technologies,  int score)  $default,) {final _that = this;
switch (_that) {
case _Applicant():
return $default(_that.id,_that.name,_that.dateOfBirth,_that.education,_that.university,_that.graduated,_that.specialty,_that.level,_that.experience,_that.workHistory,_that.languages,_that.technologies,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  DateTime dateOfBirth,  EducationType education,  String university,  bool graduated,  SpecialtyType specialty,  LevelType level,  int experience,  String workHistory,  List<String> languages,  List<String> technologies,  int score)?  $default,) {final _that = this;
switch (_that) {
case _Applicant() when $default != null:
return $default(_that.id,_that.name,_that.dateOfBirth,_that.education,_that.university,_that.graduated,_that.specialty,_that.level,_that.experience,_that.workHistory,_that.languages,_that.technologies,_that.score);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Applicant implements Applicant {
  const _Applicant({required this.id, required this.name, required this.dateOfBirth, required this.education, required this.university, required this.graduated, required this.specialty, required this.level, required this.experience, this.workHistory = "", final  List<String> languages = const [], final  List<String> technologies = const [], this.score = 0}): _languages = languages,_technologies = technologies;
  factory _Applicant.fromJson(Map<String, dynamic> json) => _$ApplicantFromJson(json);

@override final  int id;
@override final  String name;
@override final  DateTime dateOfBirth;
@override final  EducationType education;
@override final  String university;
@override final  bool graduated;
@override final  SpecialtyType specialty;
@override final  LevelType level;
@override final  int experience;
@override@JsonKey() final  String workHistory;
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

/// Create a copy of Applicant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicantCopyWith<_Applicant> get copyWith => __$ApplicantCopyWithImpl<_Applicant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApplicantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Applicant&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.education, education) || other.education == education)&&(identical(other.university, university) || other.university == university)&&(identical(other.graduated, graduated) || other.graduated == graduated)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&(identical(other.level, level) || other.level == level)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.workHistory, workHistory) || other.workHistory == workHistory)&&const DeepCollectionEquality().equals(other._languages, _languages)&&const DeepCollectionEquality().equals(other._technologies, _technologies)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,dateOfBirth,education,university,graduated,specialty,level,experience,workHistory,const DeepCollectionEquality().hash(_languages),const DeepCollectionEquality().hash(_technologies),score);

@override
String toString() {
  return 'Applicant(id: $id, name: $name, dateOfBirth: $dateOfBirth, education: $education, university: $university, graduated: $graduated, specialty: $specialty, level: $level, experience: $experience, workHistory: $workHistory, languages: $languages, technologies: $technologies, score: $score)';
}


}

/// @nodoc
abstract mixin class _$ApplicantCopyWith<$Res> implements $ApplicantCopyWith<$Res> {
  factory _$ApplicantCopyWith(_Applicant value, $Res Function(_Applicant) _then) = __$ApplicantCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, DateTime dateOfBirth, EducationType education, String university, bool graduated, SpecialtyType specialty, LevelType level, int experience, String workHistory, List<String> languages, List<String> technologies, int score
});




}
/// @nodoc
class __$ApplicantCopyWithImpl<$Res>
    implements _$ApplicantCopyWith<$Res> {
  __$ApplicantCopyWithImpl(this._self, this._then);

  final _Applicant _self;
  final $Res Function(_Applicant) _then;

/// Create a copy of Applicant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? dateOfBirth = null,Object? education = null,Object? university = null,Object? graduated = null,Object? specialty = null,Object? level = null,Object? experience = null,Object? workHistory = null,Object? languages = null,Object? technologies = null,Object? score = null,}) {
  return _then(_Applicant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: null == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime,education: null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as EducationType,university: null == university ? _self.university : university // ignore: cast_nullable_to_non_nullable
as String,graduated: null == graduated ? _self.graduated : graduated // ignore: cast_nullable_to_non_nullable
as bool,specialty: null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as SpecialtyType,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as LevelType,experience: null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as int,workHistory: null == workHistory ? _self.workHistory : workHistory // ignore: cast_nullable_to_non_nullable
as String,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,technologies: null == technologies ? _self._technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RequestForApplicant {

 int? get experience; LevelType? get level; bool? get graduated; EducationType? get education; SpecialtyType? get specialty; List<String> get languagesRequired; List<String> get languagesOptional; List<String> get technologiesRequired; List<String> get technologiesOptional;
/// Create a copy of RequestForApplicant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestForApplicantCopyWith<RequestForApplicant> get copyWith => _$RequestForApplicantCopyWithImpl<RequestForApplicant>(this as RequestForApplicant, _$identity);

  /// Serializes this RequestForApplicant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestForApplicant&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.level, level) || other.level == level)&&(identical(other.graduated, graduated) || other.graduated == graduated)&&(identical(other.education, education) || other.education == education)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&const DeepCollectionEquality().equals(other.languagesRequired, languagesRequired)&&const DeepCollectionEquality().equals(other.languagesOptional, languagesOptional)&&const DeepCollectionEquality().equals(other.technologiesRequired, technologiesRequired)&&const DeepCollectionEquality().equals(other.technologiesOptional, technologiesOptional));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,experience,level,graduated,education,specialty,const DeepCollectionEquality().hash(languagesRequired),const DeepCollectionEquality().hash(languagesOptional),const DeepCollectionEquality().hash(technologiesRequired),const DeepCollectionEquality().hash(technologiesOptional));

@override
String toString() {
  return 'RequestForApplicant(experience: $experience, level: $level, graduated: $graduated, education: $education, specialty: $specialty, languagesRequired: $languagesRequired, languagesOptional: $languagesOptional, technologiesRequired: $technologiesRequired, technologiesOptional: $technologiesOptional)';
}


}

/// @nodoc
abstract mixin class $RequestForApplicantCopyWith<$Res>  {
  factory $RequestForApplicantCopyWith(RequestForApplicant value, $Res Function(RequestForApplicant) _then) = _$RequestForApplicantCopyWithImpl;
@useResult
$Res call({
 int? experience, LevelType? level, bool? graduated, EducationType? education, SpecialtyType? specialty, List<String> languagesRequired, List<String> languagesOptional, List<String> technologiesRequired, List<String> technologiesOptional
});




}
/// @nodoc
class _$RequestForApplicantCopyWithImpl<$Res>
    implements $RequestForApplicantCopyWith<$Res> {
  _$RequestForApplicantCopyWithImpl(this._self, this._then);

  final RequestForApplicant _self;
  final $Res Function(RequestForApplicant) _then;

/// Create a copy of RequestForApplicant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? experience = freezed,Object? level = freezed,Object? graduated = freezed,Object? education = freezed,Object? specialty = freezed,Object? languagesRequired = null,Object? languagesOptional = null,Object? technologiesRequired = null,Object? technologiesOptional = null,}) {
  return _then(_self.copyWith(
experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as int?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as LevelType?,graduated: freezed == graduated ? _self.graduated : graduated // ignore: cast_nullable_to_non_nullable
as bool?,education: freezed == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as EducationType?,specialty: freezed == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as SpecialtyType?,languagesRequired: null == languagesRequired ? _self.languagesRequired : languagesRequired // ignore: cast_nullable_to_non_nullable
as List<String>,languagesOptional: null == languagesOptional ? _self.languagesOptional : languagesOptional // ignore: cast_nullable_to_non_nullable
as List<String>,technologiesRequired: null == technologiesRequired ? _self.technologiesRequired : technologiesRequired // ignore: cast_nullable_to_non_nullable
as List<String>,technologiesOptional: null == technologiesOptional ? _self.technologiesOptional : technologiesOptional // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [RequestForApplicant].
extension RequestForApplicantPatterns on RequestForApplicant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestForApplicant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestForApplicant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestForApplicant value)  $default,){
final _that = this;
switch (_that) {
case _RequestForApplicant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestForApplicant value)?  $default,){
final _that = this;
switch (_that) {
case _RequestForApplicant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? experience,  LevelType? level,  bool? graduated,  EducationType? education,  SpecialtyType? specialty,  List<String> languagesRequired,  List<String> languagesOptional,  List<String> technologiesRequired,  List<String> technologiesOptional)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestForApplicant() when $default != null:
return $default(_that.experience,_that.level,_that.graduated,_that.education,_that.specialty,_that.languagesRequired,_that.languagesOptional,_that.technologiesRequired,_that.technologiesOptional);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? experience,  LevelType? level,  bool? graduated,  EducationType? education,  SpecialtyType? specialty,  List<String> languagesRequired,  List<String> languagesOptional,  List<String> technologiesRequired,  List<String> technologiesOptional)  $default,) {final _that = this;
switch (_that) {
case _RequestForApplicant():
return $default(_that.experience,_that.level,_that.graduated,_that.education,_that.specialty,_that.languagesRequired,_that.languagesOptional,_that.technologiesRequired,_that.technologiesOptional);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? experience,  LevelType? level,  bool? graduated,  EducationType? education,  SpecialtyType? specialty,  List<String> languagesRequired,  List<String> languagesOptional,  List<String> technologiesRequired,  List<String> technologiesOptional)?  $default,) {final _that = this;
switch (_that) {
case _RequestForApplicant() when $default != null:
return $default(_that.experience,_that.level,_that.graduated,_that.education,_that.specialty,_that.languagesRequired,_that.languagesOptional,_that.technologiesRequired,_that.technologiesOptional);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _RequestForApplicant implements RequestForApplicant {
  const _RequestForApplicant({this.experience, this.level, this.graduated, this.education, this.specialty, final  List<String> languagesRequired = const [], final  List<String> languagesOptional = const [], final  List<String> technologiesRequired = const [], final  List<String> technologiesOptional = const []}): _languagesRequired = languagesRequired,_languagesOptional = languagesOptional,_technologiesRequired = technologiesRequired,_technologiesOptional = technologiesOptional;
  factory _RequestForApplicant.fromJson(Map<String, dynamic> json) => _$RequestForApplicantFromJson(json);

@override final  int? experience;
@override final  LevelType? level;
@override final  bool? graduated;
@override final  EducationType? education;
@override final  SpecialtyType? specialty;
 final  List<String> _languagesRequired;
@override@JsonKey() List<String> get languagesRequired {
  if (_languagesRequired is EqualUnmodifiableListView) return _languagesRequired;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languagesRequired);
}

 final  List<String> _languagesOptional;
@override@JsonKey() List<String> get languagesOptional {
  if (_languagesOptional is EqualUnmodifiableListView) return _languagesOptional;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languagesOptional);
}

 final  List<String> _technologiesRequired;
@override@JsonKey() List<String> get technologiesRequired {
  if (_technologiesRequired is EqualUnmodifiableListView) return _technologiesRequired;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_technologiesRequired);
}

 final  List<String> _technologiesOptional;
@override@JsonKey() List<String> get technologiesOptional {
  if (_technologiesOptional is EqualUnmodifiableListView) return _technologiesOptional;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_technologiesOptional);
}


/// Create a copy of RequestForApplicant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestForApplicantCopyWith<_RequestForApplicant> get copyWith => __$RequestForApplicantCopyWithImpl<_RequestForApplicant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestForApplicantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestForApplicant&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.level, level) || other.level == level)&&(identical(other.graduated, graduated) || other.graduated == graduated)&&(identical(other.education, education) || other.education == education)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&const DeepCollectionEquality().equals(other._languagesRequired, _languagesRequired)&&const DeepCollectionEquality().equals(other._languagesOptional, _languagesOptional)&&const DeepCollectionEquality().equals(other._technologiesRequired, _technologiesRequired)&&const DeepCollectionEquality().equals(other._technologiesOptional, _technologiesOptional));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,experience,level,graduated,education,specialty,const DeepCollectionEquality().hash(_languagesRequired),const DeepCollectionEquality().hash(_languagesOptional),const DeepCollectionEquality().hash(_technologiesRequired),const DeepCollectionEquality().hash(_technologiesOptional));

@override
String toString() {
  return 'RequestForApplicant(experience: $experience, level: $level, graduated: $graduated, education: $education, specialty: $specialty, languagesRequired: $languagesRequired, languagesOptional: $languagesOptional, technologiesRequired: $technologiesRequired, technologiesOptional: $technologiesOptional)';
}


}

/// @nodoc
abstract mixin class _$RequestForApplicantCopyWith<$Res> implements $RequestForApplicantCopyWith<$Res> {
  factory _$RequestForApplicantCopyWith(_RequestForApplicant value, $Res Function(_RequestForApplicant) _then) = __$RequestForApplicantCopyWithImpl;
@override @useResult
$Res call({
 int? experience, LevelType? level, bool? graduated, EducationType? education, SpecialtyType? specialty, List<String> languagesRequired, List<String> languagesOptional, List<String> technologiesRequired, List<String> technologiesOptional
});




}
/// @nodoc
class __$RequestForApplicantCopyWithImpl<$Res>
    implements _$RequestForApplicantCopyWith<$Res> {
  __$RequestForApplicantCopyWithImpl(this._self, this._then);

  final _RequestForApplicant _self;
  final $Res Function(_RequestForApplicant) _then;

/// Create a copy of RequestForApplicant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? experience = freezed,Object? level = freezed,Object? graduated = freezed,Object? education = freezed,Object? specialty = freezed,Object? languagesRequired = null,Object? languagesOptional = null,Object? technologiesRequired = null,Object? technologiesOptional = null,}) {
  return _then(_RequestForApplicant(
experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as int?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as LevelType?,graduated: freezed == graduated ? _self.graduated : graduated // ignore: cast_nullable_to_non_nullable
as bool?,education: freezed == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as EducationType?,specialty: freezed == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as SpecialtyType?,languagesRequired: null == languagesRequired ? _self._languagesRequired : languagesRequired // ignore: cast_nullable_to_non_nullable
as List<String>,languagesOptional: null == languagesOptional ? _self._languagesOptional : languagesOptional // ignore: cast_nullable_to_non_nullable
as List<String>,technologiesRequired: null == technologiesRequired ? _self._technologiesRequired : technologiesRequired // ignore: cast_nullable_to_non_nullable
as List<String>,technologiesOptional: null == technologiesOptional ? _self._technologiesOptional : technologiesOptional // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
