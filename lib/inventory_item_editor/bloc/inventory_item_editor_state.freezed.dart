// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_item_editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InventoryItemEditorState {

 InventoryItemEditorStatus get status;
/// Create a copy of InventoryItemEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryItemEditorStateCopyWith<InventoryItemEditorState> get copyWith => _$InventoryItemEditorStateCopyWithImpl<InventoryItemEditorState>(this as InventoryItemEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryItemEditorState&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'InventoryItemEditorState(status: $status)';
}


}

/// @nodoc
abstract mixin class $InventoryItemEditorStateCopyWith<$Res>  {
  factory $InventoryItemEditorStateCopyWith(InventoryItemEditorState value, $Res Function(InventoryItemEditorState) _then) = _$InventoryItemEditorStateCopyWithImpl;
@useResult
$Res call({
 InventoryItemEditorStatus status
});




}
/// @nodoc
class _$InventoryItemEditorStateCopyWithImpl<$Res>
    implements $InventoryItemEditorStateCopyWith<$Res> {
  _$InventoryItemEditorStateCopyWithImpl(this._self, this._then);

  final InventoryItemEditorState _self;
  final $Res Function(InventoryItemEditorState) _then;

/// Create a copy of InventoryItemEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InventoryItemEditorStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [InventoryItemEditorState].
extension InventoryItemEditorStatePatterns on InventoryItemEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InventoryItemEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InventoryItemEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InventoryItemEditorState value)  $default,){
final _that = this;
switch (_that) {
case _InventoryItemEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InventoryItemEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _InventoryItemEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InventoryItemEditorStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InventoryItemEditorState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InventoryItemEditorStatus status)  $default,) {final _that = this;
switch (_that) {
case _InventoryItemEditorState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InventoryItemEditorStatus status)?  $default,) {final _that = this;
switch (_that) {
case _InventoryItemEditorState() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _InventoryItemEditorState extends InventoryItemEditorState {
  const _InventoryItemEditorState({this.status = InventoryItemEditorStatus.idle}): super._();
  

@override@JsonKey() final  InventoryItemEditorStatus status;

/// Create a copy of InventoryItemEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InventoryItemEditorStateCopyWith<_InventoryItemEditorState> get copyWith => __$InventoryItemEditorStateCopyWithImpl<_InventoryItemEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InventoryItemEditorState&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'InventoryItemEditorState(status: $status)';
}


}

/// @nodoc
abstract mixin class _$InventoryItemEditorStateCopyWith<$Res> implements $InventoryItemEditorStateCopyWith<$Res> {
  factory _$InventoryItemEditorStateCopyWith(_InventoryItemEditorState value, $Res Function(_InventoryItemEditorState) _then) = __$InventoryItemEditorStateCopyWithImpl;
@override @useResult
$Res call({
 InventoryItemEditorStatus status
});




}
/// @nodoc
class __$InventoryItemEditorStateCopyWithImpl<$Res>
    implements _$InventoryItemEditorStateCopyWith<$Res> {
  __$InventoryItemEditorStateCopyWithImpl(this._self, this._then);

  final _InventoryItemEditorState _self;
  final $Res Function(_InventoryItemEditorState) _then;

/// Create a copy of InventoryItemEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_InventoryItemEditorState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InventoryItemEditorStatus,
  ));
}


}

// dart format on
