// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storages_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StoragesState {

 StoragesStateStatus get status; List<Storage> get storages; Exception? get error;
/// Create a copy of StoragesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoragesStateCopyWith<StoragesState> get copyWith => _$StoragesStateCopyWithImpl<StoragesState>(this as StoragesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoragesState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.storages, storages)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(storages),error);

@override
String toString() {
  return 'StoragesState(status: $status, storages: $storages, error: $error)';
}


}

/// @nodoc
abstract mixin class $StoragesStateCopyWith<$Res>  {
  factory $StoragesStateCopyWith(StoragesState value, $Res Function(StoragesState) _then) = _$StoragesStateCopyWithImpl;
@useResult
$Res call({
 StoragesStateStatus status, List<Storage> storages, Exception? error
});




}
/// @nodoc
class _$StoragesStateCopyWithImpl<$Res>
    implements $StoragesStateCopyWith<$Res> {
  _$StoragesStateCopyWithImpl(this._self, this._then);

  final StoragesState _self;
  final $Res Function(StoragesState) _then;

/// Create a copy of StoragesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? storages = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StoragesStateStatus,storages: null == storages ? _self.storages : storages // ignore: cast_nullable_to_non_nullable
as List<Storage>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Exception?,
  ));
}

}


/// Adds pattern-matching-related methods to [StoragesState].
extension StoragesStatePatterns on StoragesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoragesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoragesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoragesState value)  $default,){
final _that = this;
switch (_that) {
case _StoragesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoragesState value)?  $default,){
final _that = this;
switch (_that) {
case _StoragesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StoragesStateStatus status,  List<Storage> storages,  Exception? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoragesState() when $default != null:
return $default(_that.status,_that.storages,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StoragesStateStatus status,  List<Storage> storages,  Exception? error)  $default,) {final _that = this;
switch (_that) {
case _StoragesState():
return $default(_that.status,_that.storages,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StoragesStateStatus status,  List<Storage> storages,  Exception? error)?  $default,) {final _that = this;
switch (_that) {
case _StoragesState() when $default != null:
return $default(_that.status,_that.storages,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _StoragesState extends StoragesState {
  const _StoragesState({this.status = StoragesStateStatus.loading, final  List<Storage> storages = const [], this.error}): _storages = storages,super._();
  

@override@JsonKey() final  StoragesStateStatus status;
 final  List<Storage> _storages;
@override@JsonKey() List<Storage> get storages {
  if (_storages is EqualUnmodifiableListView) return _storages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_storages);
}

@override final  Exception? error;

/// Create a copy of StoragesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoragesStateCopyWith<_StoragesState> get copyWith => __$StoragesStateCopyWithImpl<_StoragesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoragesState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._storages, _storages)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_storages),error);

@override
String toString() {
  return 'StoragesState(status: $status, storages: $storages, error: $error)';
}


}

/// @nodoc
abstract mixin class _$StoragesStateCopyWith<$Res> implements $StoragesStateCopyWith<$Res> {
  factory _$StoragesStateCopyWith(_StoragesState value, $Res Function(_StoragesState) _then) = __$StoragesStateCopyWithImpl;
@override @useResult
$Res call({
 StoragesStateStatus status, List<Storage> storages, Exception? error
});




}
/// @nodoc
class __$StoragesStateCopyWithImpl<$Res>
    implements _$StoragesStateCopyWith<$Res> {
  __$StoragesStateCopyWithImpl(this._self, this._then);

  final _StoragesState _self;
  final $Res Function(_StoragesState) _then;

/// Create a copy of StoragesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? storages = null,Object? error = freezed,}) {
  return _then(_StoragesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StoragesStateStatus,storages: null == storages ? _self._storages : storages // ignore: cast_nullable_to_non_nullable
as List<Storage>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Exception?,
  ));
}


}

// dart format on
