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

 InventoryStateStatus get status; List<PartPresentation> get parts; InventoryFilter get filter; List<TagPresentation> get brandTags; List<TagPresentation> get categoryTags; List<Storage> get storages; InventoryStateBottomSheetStatus get bottomSheetStatus;
/// Create a copy of InventoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryStateCopyWith<InventoryState> get copyWith => _$InventoryStateCopyWithImpl<InventoryState>(this as InventoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.parts, parts)&&(identical(other.filter, filter) || other.filter == filter)&&const DeepCollectionEquality().equals(other.brandTags, brandTags)&&const DeepCollectionEquality().equals(other.categoryTags, categoryTags)&&const DeepCollectionEquality().equals(other.storages, storages)&&(identical(other.bottomSheetStatus, bottomSheetStatus) || other.bottomSheetStatus == bottomSheetStatus));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(parts),filter,const DeepCollectionEquality().hash(brandTags),const DeepCollectionEquality().hash(categoryTags),const DeepCollectionEquality().hash(storages),bottomSheetStatus);

@override
String toString() {
  return 'InventoryState(status: $status, parts: $parts, filter: $filter, brandTags: $brandTags, categoryTags: $categoryTags, storages: $storages, bottomSheetStatus: $bottomSheetStatus)';
}


}

/// @nodoc
abstract mixin class $InventoryStateCopyWith<$Res>  {
  factory $InventoryStateCopyWith(InventoryState value, $Res Function(InventoryState) _then) = _$InventoryStateCopyWithImpl;
@useResult
$Res call({
 InventoryStateStatus status, List<PartPresentation> parts, InventoryFilter filter, List<TagPresentation> brandTags, List<TagPresentation> categoryTags, List<Storage> storages, InventoryStateBottomSheetStatus bottomSheetStatus
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
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? parts = null,Object? filter = null,Object? brandTags = null,Object? categoryTags = null,Object? storages = null,Object? bottomSheetStatus = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InventoryStateStatus,parts: null == parts ? _self.parts : parts // ignore: cast_nullable_to_non_nullable
as List<PartPresentation>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as InventoryFilter,brandTags: null == brandTags ? _self.brandTags : brandTags // ignore: cast_nullable_to_non_nullable
as List<TagPresentation>,categoryTags: null == categoryTags ? _self.categoryTags : categoryTags // ignore: cast_nullable_to_non_nullable
as List<TagPresentation>,storages: null == storages ? _self.storages : storages // ignore: cast_nullable_to_non_nullable
as List<Storage>,bottomSheetStatus: null == bottomSheetStatus ? _self.bottomSheetStatus : bottomSheetStatus // ignore: cast_nullable_to_non_nullable
as InventoryStateBottomSheetStatus,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InventoryStateStatus status,  List<PartPresentation> parts,  InventoryFilter filter,  List<TagPresentation> brandTags,  List<TagPresentation> categoryTags,  List<Storage> storages,  InventoryStateBottomSheetStatus bottomSheetStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InventoryState() when $default != null:
return $default(_that.status,_that.parts,_that.filter,_that.brandTags,_that.categoryTags,_that.storages,_that.bottomSheetStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InventoryStateStatus status,  List<PartPresentation> parts,  InventoryFilter filter,  List<TagPresentation> brandTags,  List<TagPresentation> categoryTags,  List<Storage> storages,  InventoryStateBottomSheetStatus bottomSheetStatus)  $default,) {final _that = this;
switch (_that) {
case _InventoryState():
return $default(_that.status,_that.parts,_that.filter,_that.brandTags,_that.categoryTags,_that.storages,_that.bottomSheetStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InventoryStateStatus status,  List<PartPresentation> parts,  InventoryFilter filter,  List<TagPresentation> brandTags,  List<TagPresentation> categoryTags,  List<Storage> storages,  InventoryStateBottomSheetStatus bottomSheetStatus)?  $default,) {final _that = this;
switch (_that) {
case _InventoryState() when $default != null:
return $default(_that.status,_that.parts,_that.filter,_that.brandTags,_that.categoryTags,_that.storages,_that.bottomSheetStatus);case _:
  return null;

}
}

}

/// @nodoc


class _InventoryState extends InventoryState {
  const _InventoryState({this.status = InventoryStateStatus.loading, final  List<PartPresentation> parts = const [], this.filter = const InventoryFilter(), final  List<TagPresentation> brandTags = const [], final  List<TagPresentation> categoryTags = const [], final  List<Storage> storages = const [], this.bottomSheetStatus = InventoryStateBottomSheetStatus.idle}): _parts = parts,_brandTags = brandTags,_categoryTags = categoryTags,_storages = storages,super._();
  

@override@JsonKey() final  InventoryStateStatus status;
 final  List<PartPresentation> _parts;
@override@JsonKey() List<PartPresentation> get parts {
  if (_parts is EqualUnmodifiableListView) return _parts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_parts);
}

@override@JsonKey() final  InventoryFilter filter;
 final  List<TagPresentation> _brandTags;
@override@JsonKey() List<TagPresentation> get brandTags {
  if (_brandTags is EqualUnmodifiableListView) return _brandTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_brandTags);
}

 final  List<TagPresentation> _categoryTags;
@override@JsonKey() List<TagPresentation> get categoryTags {
  if (_categoryTags is EqualUnmodifiableListView) return _categoryTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryTags);
}

 final  List<Storage> _storages;
@override@JsonKey() List<Storage> get storages {
  if (_storages is EqualUnmodifiableListView) return _storages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_storages);
}

@override@JsonKey() final  InventoryStateBottomSheetStatus bottomSheetStatus;

/// Create a copy of InventoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InventoryStateCopyWith<_InventoryState> get copyWith => __$InventoryStateCopyWithImpl<_InventoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InventoryState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._parts, _parts)&&(identical(other.filter, filter) || other.filter == filter)&&const DeepCollectionEquality().equals(other._brandTags, _brandTags)&&const DeepCollectionEquality().equals(other._categoryTags, _categoryTags)&&const DeepCollectionEquality().equals(other._storages, _storages)&&(identical(other.bottomSheetStatus, bottomSheetStatus) || other.bottomSheetStatus == bottomSheetStatus));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_parts),filter,const DeepCollectionEquality().hash(_brandTags),const DeepCollectionEquality().hash(_categoryTags),const DeepCollectionEquality().hash(_storages),bottomSheetStatus);

@override
String toString() {
  return 'InventoryState(status: $status, parts: $parts, filter: $filter, brandTags: $brandTags, categoryTags: $categoryTags, storages: $storages, bottomSheetStatus: $bottomSheetStatus)';
}


}

/// @nodoc
abstract mixin class _$InventoryStateCopyWith<$Res> implements $InventoryStateCopyWith<$Res> {
  factory _$InventoryStateCopyWith(_InventoryState value, $Res Function(_InventoryState) _then) = __$InventoryStateCopyWithImpl;
@override @useResult
$Res call({
 InventoryStateStatus status, List<PartPresentation> parts, InventoryFilter filter, List<TagPresentation> brandTags, List<TagPresentation> categoryTags, List<Storage> storages, InventoryStateBottomSheetStatus bottomSheetStatus
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
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? parts = null,Object? filter = null,Object? brandTags = null,Object? categoryTags = null,Object? storages = null,Object? bottomSheetStatus = null,}) {
  return _then(_InventoryState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InventoryStateStatus,parts: null == parts ? _self._parts : parts // ignore: cast_nullable_to_non_nullable
as List<PartPresentation>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as InventoryFilter,brandTags: null == brandTags ? _self._brandTags : brandTags // ignore: cast_nullable_to_non_nullable
as List<TagPresentation>,categoryTags: null == categoryTags ? _self._categoryTags : categoryTags // ignore: cast_nullable_to_non_nullable
as List<TagPresentation>,storages: null == storages ? _self._storages : storages // ignore: cast_nullable_to_non_nullable
as List<Storage>,bottomSheetStatus: null == bottomSheetStatus ? _self.bottomSheetStatus : bottomSheetStatus // ignore: cast_nullable_to_non_nullable
as InventoryStateBottomSheetStatus,
  ));
}


}

// dart format on
