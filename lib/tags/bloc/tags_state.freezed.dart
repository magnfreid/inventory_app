// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tags_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TagsState {

 TagsStateStatus get status; TagsStateBottomSheetStatus get bottomSheetStatus; List<Tag> get tags;
/// Create a copy of TagsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagsStateCopyWith<TagsState> get copyWith => _$TagsStateCopyWithImpl<TagsState>(this as TagsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagsState&&(identical(other.status, status) || other.status == status)&&(identical(other.bottomSheetStatus, bottomSheetStatus) || other.bottomSheetStatus == bottomSheetStatus)&&const DeepCollectionEquality().equals(other.tags, tags));
}


@override
int get hashCode => Object.hash(runtimeType,status,bottomSheetStatus,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'TagsState(status: $status, bottomSheetStatus: $bottomSheetStatus, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $TagsStateCopyWith<$Res>  {
  factory $TagsStateCopyWith(TagsState value, $Res Function(TagsState) _then) = _$TagsStateCopyWithImpl;
@useResult
$Res call({
 TagsStateStatus status, TagsStateBottomSheetStatus bottomSheetStatus, List<Tag> tags
});




}
/// @nodoc
class _$TagsStateCopyWithImpl<$Res>
    implements $TagsStateCopyWith<$Res> {
  _$TagsStateCopyWithImpl(this._self, this._then);

  final TagsState _self;
  final $Res Function(TagsState) _then;

/// Create a copy of TagsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? bottomSheetStatus = null,Object? tags = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TagsStateStatus,bottomSheetStatus: null == bottomSheetStatus ? _self.bottomSheetStatus : bottomSheetStatus // ignore: cast_nullable_to_non_nullable
as TagsStateBottomSheetStatus,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<Tag>,
  ));
}

}


/// Adds pattern-matching-related methods to [TagsState].
extension TagsStatePatterns on TagsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TagsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TagsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TagsState value)  $default,){
final _that = this;
switch (_that) {
case _TagsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TagsState value)?  $default,){
final _that = this;
switch (_that) {
case _TagsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TagsStateStatus status,  TagsStateBottomSheetStatus bottomSheetStatus,  List<Tag> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TagsState() when $default != null:
return $default(_that.status,_that.bottomSheetStatus,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TagsStateStatus status,  TagsStateBottomSheetStatus bottomSheetStatus,  List<Tag> tags)  $default,) {final _that = this;
switch (_that) {
case _TagsState():
return $default(_that.status,_that.bottomSheetStatus,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TagsStateStatus status,  TagsStateBottomSheetStatus bottomSheetStatus,  List<Tag> tags)?  $default,) {final _that = this;
switch (_that) {
case _TagsState() when $default != null:
return $default(_that.status,_that.bottomSheetStatus,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _TagsState extends TagsState {
  const _TagsState({this.status = TagsStateStatus.loading, this.bottomSheetStatus = TagsStateBottomSheetStatus.idle, final  List<Tag> tags = const []}): _tags = tags,super._();
  

@override@JsonKey() final  TagsStateStatus status;
@override@JsonKey() final  TagsStateBottomSheetStatus bottomSheetStatus;
 final  List<Tag> _tags;
@override@JsonKey() List<Tag> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of TagsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagsStateCopyWith<_TagsState> get copyWith => __$TagsStateCopyWithImpl<_TagsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagsState&&(identical(other.status, status) || other.status == status)&&(identical(other.bottomSheetStatus, bottomSheetStatus) || other.bottomSheetStatus == bottomSheetStatus)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,status,bottomSheetStatus,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'TagsState(status: $status, bottomSheetStatus: $bottomSheetStatus, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$TagsStateCopyWith<$Res> implements $TagsStateCopyWith<$Res> {
  factory _$TagsStateCopyWith(_TagsState value, $Res Function(_TagsState) _then) = __$TagsStateCopyWithImpl;
@override @useResult
$Res call({
 TagsStateStatus status, TagsStateBottomSheetStatus bottomSheetStatus, List<Tag> tags
});




}
/// @nodoc
class __$TagsStateCopyWithImpl<$Res>
    implements _$TagsStateCopyWith<$Res> {
  __$TagsStateCopyWithImpl(this._self, this._then);

  final _TagsState _self;
  final $Res Function(_TagsState) _then;

/// Create a copy of TagsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? bottomSheetStatus = null,Object? tags = null,}) {
  return _then(_TagsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TagsStateStatus,bottomSheetStatus: null == bottomSheetStatus ? _self.bottomSheetStatus : bottomSheetStatus // ignore: cast_nullable_to_non_nullable
as TagsStateBottomSheetStatus,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<Tag>,
  ));
}


}

// dart format on
