// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'part_editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PartEditorState {

 PartEditorStatus get status; List<TagPresentation> get brandTags; List<TagPresentation> get categoryTags; List<TagPresentation> get generalTags; Exception? get error;
/// Create a copy of PartEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartEditorStateCopyWith<PartEditorState> get copyWith => _$PartEditorStateCopyWithImpl<PartEditorState>(this as PartEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartEditorState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.brandTags, brandTags)&&const DeepCollectionEquality().equals(other.categoryTags, categoryTags)&&const DeepCollectionEquality().equals(other.generalTags, generalTags)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(brandTags),const DeepCollectionEquality().hash(categoryTags),const DeepCollectionEquality().hash(generalTags),error);

@override
String toString() {
  return 'PartEditorState(status: $status, brandTags: $brandTags, categoryTags: $categoryTags, generalTags: $generalTags, error: $error)';
}


}

/// @nodoc
abstract mixin class $PartEditorStateCopyWith<$Res>  {
  factory $PartEditorStateCopyWith(PartEditorState value, $Res Function(PartEditorState) _then) = _$PartEditorStateCopyWithImpl;
@useResult
$Res call({
 PartEditorStatus status, List<TagPresentation> brandTags, List<TagPresentation> categoryTags, List<TagPresentation> generalTags, Exception? error
});




}
/// @nodoc
class _$PartEditorStateCopyWithImpl<$Res>
    implements $PartEditorStateCopyWith<$Res> {
  _$PartEditorStateCopyWithImpl(this._self, this._then);

  final PartEditorState _self;
  final $Res Function(PartEditorState) _then;

/// Create a copy of PartEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? brandTags = null,Object? categoryTags = null,Object? generalTags = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PartEditorStatus,brandTags: null == brandTags ? _self.brandTags : brandTags // ignore: cast_nullable_to_non_nullable
as List<TagPresentation>,categoryTags: null == categoryTags ? _self.categoryTags : categoryTags // ignore: cast_nullable_to_non_nullable
as List<TagPresentation>,generalTags: null == generalTags ? _self.generalTags : generalTags // ignore: cast_nullable_to_non_nullable
as List<TagPresentation>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Exception?,
  ));
}

}


/// Adds pattern-matching-related methods to [PartEditorState].
extension PartEditorStatePatterns on PartEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartEditorState value)  $default,){
final _that = this;
switch (_that) {
case _PartEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _PartEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PartEditorStatus status,  List<TagPresentation> brandTags,  List<TagPresentation> categoryTags,  List<TagPresentation> generalTags,  Exception? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartEditorState() when $default != null:
return $default(_that.status,_that.brandTags,_that.categoryTags,_that.generalTags,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PartEditorStatus status,  List<TagPresentation> brandTags,  List<TagPresentation> categoryTags,  List<TagPresentation> generalTags,  Exception? error)  $default,) {final _that = this;
switch (_that) {
case _PartEditorState():
return $default(_that.status,_that.brandTags,_that.categoryTags,_that.generalTags,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PartEditorStatus status,  List<TagPresentation> brandTags,  List<TagPresentation> categoryTags,  List<TagPresentation> generalTags,  Exception? error)?  $default,) {final _that = this;
switch (_that) {
case _PartEditorState() when $default != null:
return $default(_that.status,_that.brandTags,_that.categoryTags,_that.generalTags,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _PartEditorState extends PartEditorState {
  const _PartEditorState({this.status = PartEditorStatus.idle, final  List<TagPresentation> brandTags = const [], final  List<TagPresentation> categoryTags = const [], final  List<TagPresentation> generalTags = const [], this.error}): _brandTags = brandTags,_categoryTags = categoryTags,_generalTags = generalTags,super._();
  

@override@JsonKey() final  PartEditorStatus status;
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

 final  List<TagPresentation> _generalTags;
@override@JsonKey() List<TagPresentation> get generalTags {
  if (_generalTags is EqualUnmodifiableListView) return _generalTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_generalTags);
}

@override final  Exception? error;

/// Create a copy of PartEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartEditorStateCopyWith<_PartEditorState> get copyWith => __$PartEditorStateCopyWithImpl<_PartEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartEditorState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._brandTags, _brandTags)&&const DeepCollectionEquality().equals(other._categoryTags, _categoryTags)&&const DeepCollectionEquality().equals(other._generalTags, _generalTags)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_brandTags),const DeepCollectionEquality().hash(_categoryTags),const DeepCollectionEquality().hash(_generalTags),error);

@override
String toString() {
  return 'PartEditorState(status: $status, brandTags: $brandTags, categoryTags: $categoryTags, generalTags: $generalTags, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PartEditorStateCopyWith<$Res> implements $PartEditorStateCopyWith<$Res> {
  factory _$PartEditorStateCopyWith(_PartEditorState value, $Res Function(_PartEditorState) _then) = __$PartEditorStateCopyWithImpl;
@override @useResult
$Res call({
 PartEditorStatus status, List<TagPresentation> brandTags, List<TagPresentation> categoryTags, List<TagPresentation> generalTags, Exception? error
});




}
/// @nodoc
class __$PartEditorStateCopyWithImpl<$Res>
    implements _$PartEditorStateCopyWith<$Res> {
  __$PartEditorStateCopyWithImpl(this._self, this._then);

  final _PartEditorState _self;
  final $Res Function(_PartEditorState) _then;

/// Create a copy of PartEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? brandTags = null,Object? categoryTags = null,Object? generalTags = null,Object? error = freezed,}) {
  return _then(_PartEditorState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PartEditorStatus,brandTags: null == brandTags ? _self._brandTags : brandTags // ignore: cast_nullable_to_non_nullable
as List<TagPresentation>,categoryTags: null == categoryTags ? _self._categoryTags : categoryTags // ignore: cast_nullable_to_non_nullable
as List<TagPresentation>,generalTags: null == generalTags ? _self._generalTags : generalTags // ignore: cast_nullable_to_non_nullable
as List<TagPresentation>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Exception?,
  ));
}


}

// dart format on
