// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_bloc_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StockBlocState {

 StockBlocStateStatus get status;
/// Create a copy of StockBlocState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockBlocStateCopyWith<StockBlocState> get copyWith => _$StockBlocStateCopyWithImpl<StockBlocState>(this as StockBlocState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockBlocState&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'StockBlocState(status: $status)';
}


}

/// @nodoc
abstract mixin class $StockBlocStateCopyWith<$Res>  {
  factory $StockBlocStateCopyWith(StockBlocState value, $Res Function(StockBlocState) _then) = _$StockBlocStateCopyWithImpl;
@useResult
$Res call({
 StockBlocStateStatus status
});




}
/// @nodoc
class _$StockBlocStateCopyWithImpl<$Res>
    implements $StockBlocStateCopyWith<$Res> {
  _$StockBlocStateCopyWithImpl(this._self, this._then);

  final StockBlocState _self;
  final $Res Function(StockBlocState) _then;

/// Create a copy of StockBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StockBlocStateStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [StockBlocState].
extension StockBlocStatePatterns on StockBlocState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockBlocState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockBlocState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockBlocState value)  $default,){
final _that = this;
switch (_that) {
case _StockBlocState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockBlocState value)?  $default,){
final _that = this;
switch (_that) {
case _StockBlocState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StockBlocStateStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockBlocState() when $default != null:
return $default(_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StockBlocStateStatus status)  $default,) {final _that = this;
switch (_that) {
case _StockBlocState():
return $default(_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StockBlocStateStatus status)?  $default,) {final _that = this;
switch (_that) {
case _StockBlocState() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _StockBlocState extends StockBlocState {
  const _StockBlocState({this.status = StockBlocStateStatus.idle}): super._();
  

@override@JsonKey() final  StockBlocStateStatus status;

/// Create a copy of StockBlocState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockBlocStateCopyWith<_StockBlocState> get copyWith => __$StockBlocStateCopyWithImpl<_StockBlocState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockBlocState&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'StockBlocState(status: $status)';
}


}

/// @nodoc
abstract mixin class _$StockBlocStateCopyWith<$Res> implements $StockBlocStateCopyWith<$Res> {
  factory _$StockBlocStateCopyWith(_StockBlocState value, $Res Function(_StockBlocState) _then) = __$StockBlocStateCopyWithImpl;
@override @useResult
$Res call({
 StockBlocStateStatus status
});




}
/// @nodoc
class __$StockBlocStateCopyWithImpl<$Res>
    implements _$StockBlocStateCopyWith<$Res> {
  __$StockBlocStateCopyWithImpl(this._self, this._then);

  final _StockBlocState _self;
  final $Res Function(_StockBlocState) _then;

/// Create a copy of StockBlocState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_StockBlocState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StockBlocStateStatus,
  ));
}


}

// dart format on
