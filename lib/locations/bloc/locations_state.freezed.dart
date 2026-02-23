// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locations_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationsState {

 LocationsStateStatus get status; List<Location> get locations;
/// Create a copy of LocationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationsStateCopyWith<LocationsState> get copyWith => _$LocationsStateCopyWithImpl<LocationsState>(this as LocationsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.locations, locations));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(locations));

@override
String toString() {
  return 'LocationsState(status: $status, locations: $locations)';
}


}

/// @nodoc
abstract mixin class $LocationsStateCopyWith<$Res>  {
  factory $LocationsStateCopyWith(LocationsState value, $Res Function(LocationsState) _then) = _$LocationsStateCopyWithImpl;
@useResult
$Res call({
 LocationsStateStatus status, List<Location> locations
});




}
/// @nodoc
class _$LocationsStateCopyWithImpl<$Res>
    implements $LocationsStateCopyWith<$Res> {
  _$LocationsStateCopyWithImpl(this._self, this._then);

  final LocationsState _self;
  final $Res Function(LocationsState) _then;

/// Create a copy of LocationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? locations = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LocationsStateStatus,locations: null == locations ? _self.locations : locations // ignore: cast_nullable_to_non_nullable
as List<Location>,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationsState].
extension LocationsStatePatterns on LocationsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationsState value)  $default,){
final _that = this;
switch (_that) {
case _LocationsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationsState value)?  $default,){
final _that = this;
switch (_that) {
case _LocationsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocationsStateStatus status,  List<Location> locations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationsState() when $default != null:
return $default(_that.status,_that.locations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocationsStateStatus status,  List<Location> locations)  $default,) {final _that = this;
switch (_that) {
case _LocationsState():
return $default(_that.status,_that.locations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocationsStateStatus status,  List<Location> locations)?  $default,) {final _that = this;
switch (_that) {
case _LocationsState() when $default != null:
return $default(_that.status,_that.locations);case _:
  return null;

}
}

}

/// @nodoc


class _LocationsState extends LocationsState {
  const _LocationsState({this.status = LocationsStateStatus.loading, final  List<Location> locations = const []}): _locations = locations,super._();
  

@override@JsonKey() final  LocationsStateStatus status;
 final  List<Location> _locations;
@override@JsonKey() List<Location> get locations {
  if (_locations is EqualUnmodifiableListView) return _locations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_locations);
}


/// Create a copy of LocationsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationsStateCopyWith<_LocationsState> get copyWith => __$LocationsStateCopyWithImpl<_LocationsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._locations, _locations));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_locations));

@override
String toString() {
  return 'LocationsState(status: $status, locations: $locations)';
}


}

/// @nodoc
abstract mixin class _$LocationsStateCopyWith<$Res> implements $LocationsStateCopyWith<$Res> {
  factory _$LocationsStateCopyWith(_LocationsState value, $Res Function(_LocationsState) _then) = __$LocationsStateCopyWithImpl;
@override @useResult
$Res call({
 LocationsStateStatus status, List<Location> locations
});




}
/// @nodoc
class __$LocationsStateCopyWithImpl<$Res>
    implements _$LocationsStateCopyWith<$Res> {
  __$LocationsStateCopyWithImpl(this._self, this._then);

  final _LocationsState _self;
  final $Res Function(_LocationsState) _then;

/// Create a copy of LocationsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? locations = null,}) {
  return _then(_LocationsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LocationsStateStatus,locations: null == locations ? _self._locations : locations // ignore: cast_nullable_to_non_nullable
as List<Location>,
  ));
}


}

// dart format on
