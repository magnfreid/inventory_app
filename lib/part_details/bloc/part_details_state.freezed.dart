// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'part_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PartDetailsState {

 PartDetailsStatus get status; PartPresentation? get part;
/// Create a copy of PartDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartDetailsStateCopyWith<PartDetailsState> get copyWith => _$PartDetailsStateCopyWithImpl<PartDetailsState>(this as PartDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartDetailsState&&(identical(other.status, status) || other.status == status)&&(identical(other.part, part) || other.part == part));
}


@override
int get hashCode => Object.hash(runtimeType,status,part);

@override
String toString() {
  return 'PartDetailsState(status: $status, part: $part)';
}


}

/// @nodoc
abstract mixin class $PartDetailsStateCopyWith<$Res>  {
  factory $PartDetailsStateCopyWith(PartDetailsState value, $Res Function(PartDetailsState) _then) = _$PartDetailsStateCopyWithImpl;
@useResult
$Res call({
 PartDetailsStatus status, PartPresentation? part
});




}
/// @nodoc
class _$PartDetailsStateCopyWithImpl<$Res>
    implements $PartDetailsStateCopyWith<$Res> {
  _$PartDetailsStateCopyWithImpl(this._self, this._then);

  final PartDetailsState _self;
  final $Res Function(PartDetailsState) _then;

/// Create a copy of PartDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? part = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PartDetailsStatus,part: freezed == part ? _self.part : part // ignore: cast_nullable_to_non_nullable
as PartPresentation?,
  ));
}

}


/// Adds pattern-matching-related methods to [PartDetailsState].
extension PartDetailsStatePatterns on PartDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _PartDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _PartDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PartDetailsStatus status,  PartPresentation? part)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartDetailsState() when $default != null:
return $default(_that.status,_that.part);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PartDetailsStatus status,  PartPresentation? part)  $default,) {final _that = this;
switch (_that) {
case _PartDetailsState():
return $default(_that.status,_that.part);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PartDetailsStatus status,  PartPresentation? part)?  $default,) {final _that = this;
switch (_that) {
case _PartDetailsState() when $default != null:
return $default(_that.status,_that.part);case _:
  return null;

}
}

}

/// @nodoc


class _PartDetailsState extends PartDetailsState {
  const _PartDetailsState({this.status = PartDetailsStatus.loading, this.part}): super._();
  

@override@JsonKey() final  PartDetailsStatus status;
@override final  PartPresentation? part;

/// Create a copy of PartDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartDetailsStateCopyWith<_PartDetailsState> get copyWith => __$PartDetailsStateCopyWithImpl<_PartDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartDetailsState&&(identical(other.status, status) || other.status == status)&&(identical(other.part, part) || other.part == part));
}


@override
int get hashCode => Object.hash(runtimeType,status,part);

@override
String toString() {
  return 'PartDetailsState(status: $status, part: $part)';
}


}

/// @nodoc
abstract mixin class _$PartDetailsStateCopyWith<$Res> implements $PartDetailsStateCopyWith<$Res> {
  factory _$PartDetailsStateCopyWith(_PartDetailsState value, $Res Function(_PartDetailsState) _then) = __$PartDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 PartDetailsStatus status, PartPresentation? part
});




}
/// @nodoc
class __$PartDetailsStateCopyWithImpl<$Res>
    implements _$PartDetailsStateCopyWith<$Res> {
  __$PartDetailsStateCopyWithImpl(this._self, this._then);

  final _PartDetailsState _self;
  final $Res Function(_PartDetailsState) _then;

/// Create a copy of PartDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? part = freezed,}) {
  return _then(_PartDetailsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PartDetailsStatus,part: freezed == part ? _self.part : part // ignore: cast_nullable_to_non_nullable
as PartPresentation?,
  ));
}


}

// dart format on
