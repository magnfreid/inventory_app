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

 PartPresentation get part; PartDetailsContent get content; PartDetailsSaveStatus get saveStatus; PartDetailsDeleteStatus get deleteStatus; List<Storage> get storages; Exception? get error;
/// Create a copy of PartDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartDetailsStateCopyWith<PartDetailsState> get copyWith => _$PartDetailsStateCopyWithImpl<PartDetailsState>(this as PartDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartDetailsState&&(identical(other.part, part) || other.part == part)&&(identical(other.content, content) || other.content == content)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.deleteStatus, deleteStatus) || other.deleteStatus == deleteStatus)&&const DeepCollectionEquality().equals(other.storages, storages)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,part,content,saveStatus,deleteStatus,const DeepCollectionEquality().hash(storages),error);

@override
String toString() {
  return 'PartDetailsState(part: $part, content: $content, saveStatus: $saveStatus, deleteStatus: $deleteStatus, storages: $storages, error: $error)';
}


}

/// @nodoc
abstract mixin class $PartDetailsStateCopyWith<$Res>  {
  factory $PartDetailsStateCopyWith(PartDetailsState value, $Res Function(PartDetailsState) _then) = _$PartDetailsStateCopyWithImpl;
@useResult
$Res call({
 PartPresentation part, PartDetailsContent content, PartDetailsSaveStatus saveStatus, PartDetailsDeleteStatus deleteStatus, List<Storage> storages, Exception? error
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
@pragma('vm:prefer-inline') @override $Res call({Object? part = null,Object? content = null,Object? saveStatus = null,Object? deleteStatus = null,Object? storages = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
part: null == part ? _self.part : part // ignore: cast_nullable_to_non_nullable
as PartPresentation,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as PartDetailsContent,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as PartDetailsSaveStatus,deleteStatus: null == deleteStatus ? _self.deleteStatus : deleteStatus // ignore: cast_nullable_to_non_nullable
as PartDetailsDeleteStatus,storages: null == storages ? _self.storages : storages // ignore: cast_nullable_to_non_nullable
as List<Storage>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Exception?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PartPresentation part,  PartDetailsContent content,  PartDetailsSaveStatus saveStatus,  PartDetailsDeleteStatus deleteStatus,  List<Storage> storages,  Exception? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartDetailsState() when $default != null:
return $default(_that.part,_that.content,_that.saveStatus,_that.deleteStatus,_that.storages,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PartPresentation part,  PartDetailsContent content,  PartDetailsSaveStatus saveStatus,  PartDetailsDeleteStatus deleteStatus,  List<Storage> storages,  Exception? error)  $default,) {final _that = this;
switch (_that) {
case _PartDetailsState():
return $default(_that.part,_that.content,_that.saveStatus,_that.deleteStatus,_that.storages,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PartPresentation part,  PartDetailsContent content,  PartDetailsSaveStatus saveStatus,  PartDetailsDeleteStatus deleteStatus,  List<Storage> storages,  Exception? error)?  $default,) {final _that = this;
switch (_that) {
case _PartDetailsState() when $default != null:
return $default(_that.part,_that.content,_that.saveStatus,_that.deleteStatus,_that.storages,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _PartDetailsState extends PartDetailsState {
  const _PartDetailsState({required this.part, this.content = PartDetailsContent.details, this.saveStatus = PartDetailsSaveStatus.idle, this.deleteStatus = PartDetailsDeleteStatus.idle, final  List<Storage> storages = const [], this.error}): _storages = storages,super._();
  

@override final  PartPresentation part;
@override@JsonKey() final  PartDetailsContent content;
@override@JsonKey() final  PartDetailsSaveStatus saveStatus;
@override@JsonKey() final  PartDetailsDeleteStatus deleteStatus;
 final  List<Storage> _storages;
@override@JsonKey() List<Storage> get storages {
  if (_storages is EqualUnmodifiableListView) return _storages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_storages);
}

@override final  Exception? error;

/// Create a copy of PartDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartDetailsStateCopyWith<_PartDetailsState> get copyWith => __$PartDetailsStateCopyWithImpl<_PartDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartDetailsState&&(identical(other.part, part) || other.part == part)&&(identical(other.content, content) || other.content == content)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.deleteStatus, deleteStatus) || other.deleteStatus == deleteStatus)&&const DeepCollectionEquality().equals(other._storages, _storages)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,part,content,saveStatus,deleteStatus,const DeepCollectionEquality().hash(_storages),error);

@override
String toString() {
  return 'PartDetailsState(part: $part, content: $content, saveStatus: $saveStatus, deleteStatus: $deleteStatus, storages: $storages, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PartDetailsStateCopyWith<$Res> implements $PartDetailsStateCopyWith<$Res> {
  factory _$PartDetailsStateCopyWith(_PartDetailsState value, $Res Function(_PartDetailsState) _then) = __$PartDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 PartPresentation part, PartDetailsContent content, PartDetailsSaveStatus saveStatus, PartDetailsDeleteStatus deleteStatus, List<Storage> storages, Exception? error
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
@override @pragma('vm:prefer-inline') $Res call({Object? part = null,Object? content = null,Object? saveStatus = null,Object? deleteStatus = null,Object? storages = null,Object? error = freezed,}) {
  return _then(_PartDetailsState(
part: null == part ? _self.part : part // ignore: cast_nullable_to_non_nullable
as PartPresentation,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as PartDetailsContent,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as PartDetailsSaveStatus,deleteStatus: null == deleteStatus ? _self.deleteStatus : deleteStatus // ignore: cast_nullable_to_non_nullable
as PartDetailsDeleteStatus,storages: null == storages ? _self._storages : storages // ignore: cast_nullable_to_non_nullable
as List<Storage>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Exception?,
  ));
}


}

// dart format on
