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

 PartDetailsStatus get status; PartDetailsContent get content; PartPresentation? get part; PartDetailsSaveStatus get saveStatus; List<Storage> get storages;
/// Create a copy of PartDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartDetailsStateCopyWith<PartDetailsState> get copyWith => _$PartDetailsStateCopyWithImpl<PartDetailsState>(this as PartDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartDetailsState&&(identical(other.status, status) || other.status == status)&&(identical(other.content, content) || other.content == content)&&(identical(other.part, part) || other.part == part)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&const DeepCollectionEquality().equals(other.storages, storages));
}


@override
int get hashCode => Object.hash(runtimeType,status,content,part,saveStatus,const DeepCollectionEquality().hash(storages));

@override
String toString() {
  return 'PartDetailsState(status: $status, content: $content, part: $part, saveStatus: $saveStatus, storages: $storages)';
}


}

/// @nodoc
abstract mixin class $PartDetailsStateCopyWith<$Res>  {
  factory $PartDetailsStateCopyWith(PartDetailsState value, $Res Function(PartDetailsState) _then) = _$PartDetailsStateCopyWithImpl;
@useResult
$Res call({
 PartDetailsStatus status, PartDetailsContent content, PartPresentation? part, PartDetailsSaveStatus saveStatus, List<Storage> storages
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
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? content = null,Object? part = freezed,Object? saveStatus = null,Object? storages = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PartDetailsStatus,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as PartDetailsContent,part: freezed == part ? _self.part : part // ignore: cast_nullable_to_non_nullable
as PartPresentation?,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as PartDetailsSaveStatus,storages: null == storages ? _self.storages : storages // ignore: cast_nullable_to_non_nullable
as List<Storage>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PartDetailsStatus status,  PartDetailsContent content,  PartPresentation? part,  PartDetailsSaveStatus saveStatus,  List<Storage> storages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartDetailsState() when $default != null:
return $default(_that.status,_that.content,_that.part,_that.saveStatus,_that.storages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PartDetailsStatus status,  PartDetailsContent content,  PartPresentation? part,  PartDetailsSaveStatus saveStatus,  List<Storage> storages)  $default,) {final _that = this;
switch (_that) {
case _PartDetailsState():
return $default(_that.status,_that.content,_that.part,_that.saveStatus,_that.storages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PartDetailsStatus status,  PartDetailsContent content,  PartPresentation? part,  PartDetailsSaveStatus saveStatus,  List<Storage> storages)?  $default,) {final _that = this;
switch (_that) {
case _PartDetailsState() when $default != null:
return $default(_that.status,_that.content,_that.part,_that.saveStatus,_that.storages);case _:
  return null;

}
}

}

/// @nodoc


class _PartDetailsState extends PartDetailsState {
  const _PartDetailsState({this.status = PartDetailsStatus.loading, this.content = PartDetailsContent.details, this.part, this.saveStatus = PartDetailsSaveStatus.idle, final  List<Storage> storages = const []}): _storages = storages,super._();
  

@override@JsonKey() final  PartDetailsStatus status;
@override@JsonKey() final  PartDetailsContent content;
@override final  PartPresentation? part;
@override@JsonKey() final  PartDetailsSaveStatus saveStatus;
 final  List<Storage> _storages;
@override@JsonKey() List<Storage> get storages {
  if (_storages is EqualUnmodifiableListView) return _storages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_storages);
}


/// Create a copy of PartDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartDetailsStateCopyWith<_PartDetailsState> get copyWith => __$PartDetailsStateCopyWithImpl<_PartDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartDetailsState&&(identical(other.status, status) || other.status == status)&&(identical(other.content, content) || other.content == content)&&(identical(other.part, part) || other.part == part)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&const DeepCollectionEquality().equals(other._storages, _storages));
}


@override
int get hashCode => Object.hash(runtimeType,status,content,part,saveStatus,const DeepCollectionEquality().hash(_storages));

@override
String toString() {
  return 'PartDetailsState(status: $status, content: $content, part: $part, saveStatus: $saveStatus, storages: $storages)';
}


}

/// @nodoc
abstract mixin class _$PartDetailsStateCopyWith<$Res> implements $PartDetailsStateCopyWith<$Res> {
  factory _$PartDetailsStateCopyWith(_PartDetailsState value, $Res Function(_PartDetailsState) _then) = __$PartDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 PartDetailsStatus status, PartDetailsContent content, PartPresentation? part, PartDetailsSaveStatus saveStatus, List<Storage> storages
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
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? content = null,Object? part = freezed,Object? saveStatus = null,Object? storages = null,}) {
  return _then(_PartDetailsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PartDetailsStatus,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as PartDetailsContent,part: freezed == part ? _self.part : part // ignore: cast_nullable_to_non_nullable
as PartPresentation?,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as PartDetailsSaveStatus,storages: null == storages ? _self._storages : storages // ignore: cast_nullable_to_non_nullable
as List<Storage>,
  ));
}


}

// dart format on
