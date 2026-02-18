// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalogue_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CatalogueState {

 CatalogueStateStatus get status; List<CatalogueItem> get items;
/// Create a copy of CatalogueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogueStateCopyWith<CatalogueState> get copyWith => _$CatalogueStateCopyWithImpl<CatalogueState>(this as CatalogueState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogueState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'CatalogueState(status: $status, items: $items)';
}


}

/// @nodoc
abstract mixin class $CatalogueStateCopyWith<$Res>  {
  factory $CatalogueStateCopyWith(CatalogueState value, $Res Function(CatalogueState) _then) = _$CatalogueStateCopyWithImpl;
@useResult
$Res call({
 CatalogueStateStatus status, List<CatalogueItem> items
});




}
/// @nodoc
class _$CatalogueStateCopyWithImpl<$Res>
    implements $CatalogueStateCopyWith<$Res> {
  _$CatalogueStateCopyWithImpl(this._self, this._then);

  final CatalogueState _self;
  final $Res Function(CatalogueState) _then;

/// Create a copy of CatalogueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? items = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CatalogueStateStatus,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CatalogueItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogueState].
extension CatalogueStatePatterns on CatalogueState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogueState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogueState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogueState value)  $default,){
final _that = this;
switch (_that) {
case _CatalogueState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogueState value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogueState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CatalogueStateStatus status,  List<CatalogueItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogueState() when $default != null:
return $default(_that.status,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CatalogueStateStatus status,  List<CatalogueItem> items)  $default,) {final _that = this;
switch (_that) {
case _CatalogueState():
return $default(_that.status,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CatalogueStateStatus status,  List<CatalogueItem> items)?  $default,) {final _that = this;
switch (_that) {
case _CatalogueState() when $default != null:
return $default(_that.status,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _CatalogueState extends CatalogueState {
  const _CatalogueState({this.status = CatalogueStateStatus.loading, final  List<CatalogueItem> items = const []}): _items = items,super._();
  

@override@JsonKey() final  CatalogueStateStatus status;
 final  List<CatalogueItem> _items;
@override@JsonKey() List<CatalogueItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of CatalogueState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogueStateCopyWith<_CatalogueState> get copyWith => __$CatalogueStateCopyWithImpl<_CatalogueState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogueState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'CatalogueState(status: $status, items: $items)';
}


}

/// @nodoc
abstract mixin class _$CatalogueStateCopyWith<$Res> implements $CatalogueStateCopyWith<$Res> {
  factory _$CatalogueStateCopyWith(_CatalogueState value, $Res Function(_CatalogueState) _then) = __$CatalogueStateCopyWithImpl;
@override @useResult
$Res call({
 CatalogueStateStatus status, List<CatalogueItem> items
});




}
/// @nodoc
class __$CatalogueStateCopyWithImpl<$Res>
    implements _$CatalogueStateCopyWith<$Res> {
  __$CatalogueStateCopyWithImpl(this._self, this._then);

  final _CatalogueState _self;
  final $Res Function(_CatalogueState) _then;

/// Create a copy of CatalogueState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? items = null,}) {
  return _then(_CatalogueState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CatalogueStateStatus,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CatalogueItem>,
  ));
}


}

// dart format on
