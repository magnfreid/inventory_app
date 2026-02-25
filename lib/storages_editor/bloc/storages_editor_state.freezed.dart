// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storages_editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StoragesEditorState {

 StoragesEditorStatus get status;
/// Create a copy of StoragesEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoragesEditorStateCopyWith<StoragesEditorState> get copyWith => _$StoragesEditorStateCopyWithImpl<StoragesEditorState>(this as StoragesEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoragesEditorState&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'StoragesEditorState(status: $status)';
}


}

/// @nodoc
abstract mixin class $StoragesEditorStateCopyWith<$Res>  {
  factory $StoragesEditorStateCopyWith(StoragesEditorState value, $Res Function(StoragesEditorState) _then) = _$StoragesEditorStateCopyWithImpl;
@useResult
$Res call({
 StoragesEditorStatus status
});




}
/// @nodoc
class _$StoragesEditorStateCopyWithImpl<$Res>
    implements $StoragesEditorStateCopyWith<$Res> {
  _$StoragesEditorStateCopyWithImpl(this._self, this._then);

  final StoragesEditorState _self;
  final $Res Function(StoragesEditorState) _then;

/// Create a copy of StoragesEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StoragesEditorStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [StoragesEditorState].
extension StoragesEditorStatePatterns on StoragesEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoragesEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoragesEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoragesEditorState value)  $default,){
final _that = this;
switch (_that) {
case _StoragesEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoragesEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _StoragesEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StoragesEditorStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoragesEditorState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StoragesEditorStatus status)  $default,) {final _that = this;
switch (_that) {
case _StoragesEditorState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StoragesEditorStatus status)?  $default,) {final _that = this;
switch (_that) {
case _StoragesEditorState() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _StoragesEditorState extends StoragesEditorState {
  const _StoragesEditorState({this.status = StoragesEditorStatus.idle}): super._();
  

@override@JsonKey() final  StoragesEditorStatus status;

/// Create a copy of StoragesEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoragesEditorStateCopyWith<_StoragesEditorState> get copyWith => __$StoragesEditorStateCopyWithImpl<_StoragesEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoragesEditorState&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'StoragesEditorState(status: $status)';
}


}

/// @nodoc
abstract mixin class _$StoragesEditorStateCopyWith<$Res> implements $StoragesEditorStateCopyWith<$Res> {
  factory _$StoragesEditorStateCopyWith(_StoragesEditorState value, $Res Function(_StoragesEditorState) _then) = __$StoragesEditorStateCopyWithImpl;
@override @useResult
$Res call({
 StoragesEditorStatus status
});




}
/// @nodoc
class __$StoragesEditorStateCopyWithImpl<$Res>
    implements _$StoragesEditorStateCopyWith<$Res> {
  __$StoragesEditorStateCopyWithImpl(this._self, this._then);

  final _StoragesEditorState _self;
  final $Res Function(_StoragesEditorState) _then;

/// Create a copy of StoragesEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_StoragesEditorState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StoragesEditorStatus,
  ));
}


}

// dart format on
