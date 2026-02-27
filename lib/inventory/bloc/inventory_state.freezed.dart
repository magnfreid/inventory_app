// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InventoryState {

 InventoryStateStatus get status; InventoryStateBottomSheetStatus get bottomSheetStatus; List<PartUiModel> get parts;
/// Create a copy of InventoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryStateCopyWith<InventoryState> get copyWith => _$InventoryStateCopyWithImpl<InventoryState>(this as InventoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryState&&(identical(other.status, status) || other.status == status)&&(identical(other.bottomSheetStatus, bottomSheetStatus) || other.bottomSheetStatus == bottomSheetStatus)&&const DeepCollectionEquality().equals(other.parts, parts));
}


@override
int get hashCode => Object.hash(runtimeType,status,bottomSheetStatus,const DeepCollectionEquality().hash(parts));

@override
String toString() {
  return 'InventoryState(status: $status, bottomSheetStatus: $bottomSheetStatus, parts: $parts)';
}


}

/// @nodoc
abstract mixin class $InventoryStateCopyWith<$Res>  {
  factory $InventoryStateCopyWith(InventoryState value, $Res Function(InventoryState) _then) = _$InventoryStateCopyWithImpl;
@useResult
$Res call({
 InventoryStateStatus status, InventoryStateBottomSheetStatus bottomSheetStatus, List<PartUiModel> parts
});




}
/// @nodoc
class _$InventoryStateCopyWithImpl<$Res>
    implements $InventoryStateCopyWith<$Res> {
  _$InventoryStateCopyWithImpl(this._self, this._then);

  final InventoryState _self;
  final $Res Function(InventoryState) _then;

/// Create a copy of InventoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? bottomSheetStatus = null,Object? parts = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InventoryStateStatus,bottomSheetStatus: null == bottomSheetStatus ? _self.bottomSheetStatus : bottomSheetStatus // ignore: cast_nullable_to_non_nullable
as InventoryStateBottomSheetStatus,parts: null == parts ? _self.parts : parts // ignore: cast_nullable_to_non_nullable
as List<PartUiModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [InventoryState].
extension InventoryStatePatterns on InventoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InventoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InventoryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InventoryState value)  $default,){
final _that = this;
switch (_that) {
case _InventoryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InventoryState value)?  $default,){
final _that = this;
switch (_that) {
case _InventoryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InventoryStateStatus status,  InventoryStateBottomSheetStatus bottomSheetStatus,  List<PartUiModel> parts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InventoryState() when $default != null:
return $default(_that.status,_that.bottomSheetStatus,_that.parts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InventoryStateStatus status,  InventoryStateBottomSheetStatus bottomSheetStatus,  List<PartUiModel> parts)  $default,) {final _that = this;
switch (_that) {
case _InventoryState():
return $default(_that.status,_that.bottomSheetStatus,_that.parts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InventoryStateStatus status,  InventoryStateBottomSheetStatus bottomSheetStatus,  List<PartUiModel> parts)?  $default,) {final _that = this;
switch (_that) {
case _InventoryState() when $default != null:
return $default(_that.status,_that.bottomSheetStatus,_that.parts);case _:
  return null;

}
}

}

/// @nodoc


class _InventoryState extends InventoryState {
  const _InventoryState({this.status = InventoryStateStatus.loading, this.bottomSheetStatus = InventoryStateBottomSheetStatus.idle, final  List<PartUiModel> parts = const []}): _parts = parts,super._();
  

@override@JsonKey() final  InventoryStateStatus status;
@override@JsonKey() final  InventoryStateBottomSheetStatus bottomSheetStatus;
 final  List<PartUiModel> _parts;
@override@JsonKey() List<PartUiModel> get parts {
  if (_parts is EqualUnmodifiableListView) return _parts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_parts);
}


/// Create a copy of InventoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InventoryStateCopyWith<_InventoryState> get copyWith => __$InventoryStateCopyWithImpl<_InventoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InventoryState&&(identical(other.status, status) || other.status == status)&&(identical(other.bottomSheetStatus, bottomSheetStatus) || other.bottomSheetStatus == bottomSheetStatus)&&const DeepCollectionEquality().equals(other._parts, _parts));
}


@override
int get hashCode => Object.hash(runtimeType,status,bottomSheetStatus,const DeepCollectionEquality().hash(_parts));

@override
String toString() {
  return 'InventoryState(status: $status, bottomSheetStatus: $bottomSheetStatus, parts: $parts)';
}


}

/// @nodoc
abstract mixin class _$InventoryStateCopyWith<$Res> implements $InventoryStateCopyWith<$Res> {
  factory _$InventoryStateCopyWith(_InventoryState value, $Res Function(_InventoryState) _then) = __$InventoryStateCopyWithImpl;
@override @useResult
$Res call({
 InventoryStateStatus status, InventoryStateBottomSheetStatus bottomSheetStatus, List<PartUiModel> parts
});




}
/// @nodoc
class __$InventoryStateCopyWithImpl<$Res>
    implements _$InventoryStateCopyWith<$Res> {
  __$InventoryStateCopyWithImpl(this._self, this._then);

  final _InventoryState _self;
  final $Res Function(_InventoryState) _then;

/// Create a copy of InventoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? bottomSheetStatus = null,Object? parts = null,}) {
  return _then(_InventoryState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InventoryStateStatus,bottomSheetStatus: null == bottomSheetStatus ? _self.bottomSheetStatus : bottomSheetStatus // ignore: cast_nullable_to_non_nullable
as InventoryStateBottomSheetStatus,parts: null == parts ? _self._parts : parts // ignore: cast_nullable_to_non_nullable
as List<PartUiModel>,
  ));
}


}

// dart format on
