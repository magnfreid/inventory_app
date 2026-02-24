// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_item_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InventoryItemDetailsState {

 InventoryItemDetailsStatus get status; InventoryItemDetailsSaveStatus get saveStatus; List<Location> get locations; bool get showAddView;
/// Create a copy of InventoryItemDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryItemDetailsStateCopyWith<InventoryItemDetailsState> get copyWith => _$InventoryItemDetailsStateCopyWithImpl<InventoryItemDetailsState>(this as InventoryItemDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryItemDetailsState&&(identical(other.status, status) || other.status == status)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&const DeepCollectionEquality().equals(other.locations, locations)&&(identical(other.showAddView, showAddView) || other.showAddView == showAddView));
}


@override
int get hashCode => Object.hash(runtimeType,status,saveStatus,const DeepCollectionEquality().hash(locations),showAddView);

@override
String toString() {
  return 'InventoryItemDetailsState(status: $status, saveStatus: $saveStatus, locations: $locations, showAddView: $showAddView)';
}


}

/// @nodoc
abstract mixin class $InventoryItemDetailsStateCopyWith<$Res>  {
  factory $InventoryItemDetailsStateCopyWith(InventoryItemDetailsState value, $Res Function(InventoryItemDetailsState) _then) = _$InventoryItemDetailsStateCopyWithImpl;
@useResult
$Res call({
 InventoryItemDetailsStatus status, InventoryItemDetailsSaveStatus saveStatus, List<Location> locations, bool showAddView
});




}
/// @nodoc
class _$InventoryItemDetailsStateCopyWithImpl<$Res>
    implements $InventoryItemDetailsStateCopyWith<$Res> {
  _$InventoryItemDetailsStateCopyWithImpl(this._self, this._then);

  final InventoryItemDetailsState _self;
  final $Res Function(InventoryItemDetailsState) _then;

/// Create a copy of InventoryItemDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? saveStatus = null,Object? locations = null,Object? showAddView = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InventoryItemDetailsStatus,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as InventoryItemDetailsSaveStatus,locations: null == locations ? _self.locations : locations // ignore: cast_nullable_to_non_nullable
as List<Location>,showAddView: null == showAddView ? _self.showAddView : showAddView // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [InventoryItemDetailsState].
extension InventoryItemDetailsStatePatterns on InventoryItemDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InventoryItemDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InventoryItemDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InventoryItemDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _InventoryItemDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InventoryItemDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _InventoryItemDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InventoryItemDetailsStatus status,  InventoryItemDetailsSaveStatus saveStatus,  List<Location> locations,  bool showAddView)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InventoryItemDetailsState() when $default != null:
return $default(_that.status,_that.saveStatus,_that.locations,_that.showAddView);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InventoryItemDetailsStatus status,  InventoryItemDetailsSaveStatus saveStatus,  List<Location> locations,  bool showAddView)  $default,) {final _that = this;
switch (_that) {
case _InventoryItemDetailsState():
return $default(_that.status,_that.saveStatus,_that.locations,_that.showAddView);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InventoryItemDetailsStatus status,  InventoryItemDetailsSaveStatus saveStatus,  List<Location> locations,  bool showAddView)?  $default,) {final _that = this;
switch (_that) {
case _InventoryItemDetailsState() when $default != null:
return $default(_that.status,_that.saveStatus,_that.locations,_that.showAddView);case _:
  return null;

}
}

}

/// @nodoc


class _InventoryItemDetailsState extends InventoryItemDetailsState {
  const _InventoryItemDetailsState({this.status = InventoryItemDetailsStatus.loading, this.saveStatus = InventoryItemDetailsSaveStatus.idle, final  List<Location> locations = const [], this.showAddView = false}): _locations = locations,super._();
  

@override@JsonKey() final  InventoryItemDetailsStatus status;
@override@JsonKey() final  InventoryItemDetailsSaveStatus saveStatus;
 final  List<Location> _locations;
@override@JsonKey() List<Location> get locations {
  if (_locations is EqualUnmodifiableListView) return _locations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_locations);
}

@override@JsonKey() final  bool showAddView;

/// Create a copy of InventoryItemDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InventoryItemDetailsStateCopyWith<_InventoryItemDetailsState> get copyWith => __$InventoryItemDetailsStateCopyWithImpl<_InventoryItemDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InventoryItemDetailsState&&(identical(other.status, status) || other.status == status)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&const DeepCollectionEquality().equals(other._locations, _locations)&&(identical(other.showAddView, showAddView) || other.showAddView == showAddView));
}


@override
int get hashCode => Object.hash(runtimeType,status,saveStatus,const DeepCollectionEquality().hash(_locations),showAddView);

@override
String toString() {
  return 'InventoryItemDetailsState(status: $status, saveStatus: $saveStatus, locations: $locations, showAddView: $showAddView)';
}


}

/// @nodoc
abstract mixin class _$InventoryItemDetailsStateCopyWith<$Res> implements $InventoryItemDetailsStateCopyWith<$Res> {
  factory _$InventoryItemDetailsStateCopyWith(_InventoryItemDetailsState value, $Res Function(_InventoryItemDetailsState) _then) = __$InventoryItemDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 InventoryItemDetailsStatus status, InventoryItemDetailsSaveStatus saveStatus, List<Location> locations, bool showAddView
});




}
/// @nodoc
class __$InventoryItemDetailsStateCopyWithImpl<$Res>
    implements _$InventoryItemDetailsStateCopyWith<$Res> {
  __$InventoryItemDetailsStateCopyWithImpl(this._self, this._then);

  final _InventoryItemDetailsState _self;
  final $Res Function(_InventoryItemDetailsState) _then;

/// Create a copy of InventoryItemDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? saveStatus = null,Object? locations = null,Object? showAddView = null,}) {
  return _then(_InventoryItemDetailsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InventoryItemDetailsStatus,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as InventoryItemDetailsSaveStatus,locations: null == locations ? _self._locations : locations // ignore: cast_nullable_to_non_nullable
as List<Location>,showAddView: null == showAddView ? _self.showAddView : showAddView // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
