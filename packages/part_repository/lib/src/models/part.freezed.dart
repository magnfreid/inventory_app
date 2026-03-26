// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'part.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Part {

 String? get id; String get name; String get detailNumber; double get price; bool get isRecycled; List<String> get generalTagIds; String? get brandTagId; String? get categoryTagId; String? get description; String? get imgPath;
/// Create a copy of Part
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartCopyWith<Part> get copyWith => _$PartCopyWithImpl<Part>(this as Part, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Part&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.detailNumber, detailNumber) || other.detailNumber == detailNumber)&&(identical(other.price, price) || other.price == price)&&(identical(other.isRecycled, isRecycled) || other.isRecycled == isRecycled)&&const DeepCollectionEquality().equals(other.generalTagIds, generalTagIds)&&(identical(other.brandTagId, brandTagId) || other.brandTagId == brandTagId)&&(identical(other.categoryTagId, categoryTagId) || other.categoryTagId == categoryTagId)&&(identical(other.description, description) || other.description == description)&&(identical(other.imgPath, imgPath) || other.imgPath == imgPath));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,detailNumber,price,isRecycled,const DeepCollectionEquality().hash(generalTagIds),brandTagId,categoryTagId,description,imgPath);

@override
String toString() {
  return 'Part(id: $id, name: $name, detailNumber: $detailNumber, price: $price, isRecycled: $isRecycled, generalTagIds: $generalTagIds, brandTagId: $brandTagId, categoryTagId: $categoryTagId, description: $description, imgPath: $imgPath)';
}


}

/// @nodoc
abstract mixin class $PartCopyWith<$Res>  {
  factory $PartCopyWith(Part value, $Res Function(Part) _then) = _$PartCopyWithImpl;
@useResult
$Res call({
 String? id, String name, String detailNumber, double price, bool isRecycled, List<String> generalTagIds, String? brandTagId, String? categoryTagId, String? description, String? imgPath
});




}
/// @nodoc
class _$PartCopyWithImpl<$Res>
    implements $PartCopyWith<$Res> {
  _$PartCopyWithImpl(this._self, this._then);

  final Part _self;
  final $Res Function(Part) _then;

/// Create a copy of Part
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? detailNumber = null,Object? price = null,Object? isRecycled = null,Object? generalTagIds = null,Object? brandTagId = freezed,Object? categoryTagId = freezed,Object? description = freezed,Object? imgPath = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,detailNumber: null == detailNumber ? _self.detailNumber : detailNumber // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,isRecycled: null == isRecycled ? _self.isRecycled : isRecycled // ignore: cast_nullable_to_non_nullable
as bool,generalTagIds: null == generalTagIds ? _self.generalTagIds : generalTagIds // ignore: cast_nullable_to_non_nullable
as List<String>,brandTagId: freezed == brandTagId ? _self.brandTagId : brandTagId // ignore: cast_nullable_to_non_nullable
as String?,categoryTagId: freezed == categoryTagId ? _self.categoryTagId : categoryTagId // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imgPath: freezed == imgPath ? _self.imgPath : imgPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Part].
extension PartPatterns on Part {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Part value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Part() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Part value)  $default,){
final _that = this;
switch (_that) {
case _Part():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Part value)?  $default,){
final _that = this;
switch (_that) {
case _Part() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String name,  String detailNumber,  double price,  bool isRecycled,  List<String> generalTagIds,  String? brandTagId,  String? categoryTagId,  String? description,  String? imgPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Part() when $default != null:
return $default(_that.id,_that.name,_that.detailNumber,_that.price,_that.isRecycled,_that.generalTagIds,_that.brandTagId,_that.categoryTagId,_that.description,_that.imgPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String name,  String detailNumber,  double price,  bool isRecycled,  List<String> generalTagIds,  String? brandTagId,  String? categoryTagId,  String? description,  String? imgPath)  $default,) {final _that = this;
switch (_that) {
case _Part():
return $default(_that.id,_that.name,_that.detailNumber,_that.price,_that.isRecycled,_that.generalTagIds,_that.brandTagId,_that.categoryTagId,_that.description,_that.imgPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String name,  String detailNumber,  double price,  bool isRecycled,  List<String> generalTagIds,  String? brandTagId,  String? categoryTagId,  String? description,  String? imgPath)?  $default,) {final _that = this;
switch (_that) {
case _Part() when $default != null:
return $default(_that.id,_that.name,_that.detailNumber,_that.price,_that.isRecycled,_that.generalTagIds,_that.brandTagId,_that.categoryTagId,_that.description,_that.imgPath);case _:
  return null;

}
}

}

/// @nodoc


class _Part extends Part {
  const _Part({required this.id, required this.name, required this.detailNumber, required this.price, required this.isRecycled, required final  List<String> generalTagIds, required this.brandTagId, required this.categoryTagId, required this.description, required this.imgPath}): _generalTagIds = generalTagIds,super._();
  

@override final  String? id;
@override final  String name;
@override final  String detailNumber;
@override final  double price;
@override final  bool isRecycled;
 final  List<String> _generalTagIds;
@override List<String> get generalTagIds {
  if (_generalTagIds is EqualUnmodifiableListView) return _generalTagIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_generalTagIds);
}

@override final  String? brandTagId;
@override final  String? categoryTagId;
@override final  String? description;
@override final  String? imgPath;

/// Create a copy of Part
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartCopyWith<_Part> get copyWith => __$PartCopyWithImpl<_Part>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Part&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.detailNumber, detailNumber) || other.detailNumber == detailNumber)&&(identical(other.price, price) || other.price == price)&&(identical(other.isRecycled, isRecycled) || other.isRecycled == isRecycled)&&const DeepCollectionEquality().equals(other._generalTagIds, _generalTagIds)&&(identical(other.brandTagId, brandTagId) || other.brandTagId == brandTagId)&&(identical(other.categoryTagId, categoryTagId) || other.categoryTagId == categoryTagId)&&(identical(other.description, description) || other.description == description)&&(identical(other.imgPath, imgPath) || other.imgPath == imgPath));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,detailNumber,price,isRecycled,const DeepCollectionEquality().hash(_generalTagIds),brandTagId,categoryTagId,description,imgPath);

@override
String toString() {
  return 'Part(id: $id, name: $name, detailNumber: $detailNumber, price: $price, isRecycled: $isRecycled, generalTagIds: $generalTagIds, brandTagId: $brandTagId, categoryTagId: $categoryTagId, description: $description, imgPath: $imgPath)';
}


}

/// @nodoc
abstract mixin class _$PartCopyWith<$Res> implements $PartCopyWith<$Res> {
  factory _$PartCopyWith(_Part value, $Res Function(_Part) _then) = __$PartCopyWithImpl;
@override @useResult
$Res call({
 String? id, String name, String detailNumber, double price, bool isRecycled, List<String> generalTagIds, String? brandTagId, String? categoryTagId, String? description, String? imgPath
});




}
/// @nodoc
class __$PartCopyWithImpl<$Res>
    implements _$PartCopyWith<$Res> {
  __$PartCopyWithImpl(this._self, this._then);

  final _Part _self;
  final $Res Function(_Part) _then;

/// Create a copy of Part
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? detailNumber = null,Object? price = null,Object? isRecycled = null,Object? generalTagIds = null,Object? brandTagId = freezed,Object? categoryTagId = freezed,Object? description = freezed,Object? imgPath = freezed,}) {
  return _then(_Part(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,detailNumber: null == detailNumber ? _self.detailNumber : detailNumber // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,isRecycled: null == isRecycled ? _self.isRecycled : isRecycled // ignore: cast_nullable_to_non_nullable
as bool,generalTagIds: null == generalTagIds ? _self._generalTagIds : generalTagIds // ignore: cast_nullable_to_non_nullable
as List<String>,brandTagId: freezed == brandTagId ? _self.brandTagId : brandTagId // ignore: cast_nullable_to_non_nullable
as String?,categoryTagId: freezed == categoryTagId ? _self.categoryTagId : categoryTagId // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imgPath: freezed == imgPath ? _self.imgPath : imgPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
