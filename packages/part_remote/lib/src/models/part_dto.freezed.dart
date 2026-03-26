// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'part_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartDto {

 String get name; String get detailNumber; bool get isRecycled; double get price; String? get categoryTagId; String? get brandTagId; String? get description; List<String> get generalTagIds; String? get imgPath; String? get id;
/// Create a copy of PartDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartDtoCopyWith<PartDto> get copyWith => _$PartDtoCopyWithImpl<PartDto>(this as PartDto, _$identity);

  /// Serializes this PartDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartDto&&(identical(other.name, name) || other.name == name)&&(identical(other.detailNumber, detailNumber) || other.detailNumber == detailNumber)&&(identical(other.isRecycled, isRecycled) || other.isRecycled == isRecycled)&&(identical(other.price, price) || other.price == price)&&(identical(other.categoryTagId, categoryTagId) || other.categoryTagId == categoryTagId)&&(identical(other.brandTagId, brandTagId) || other.brandTagId == brandTagId)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.generalTagIds, generalTagIds)&&(identical(other.imgPath, imgPath) || other.imgPath == imgPath)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,detailNumber,isRecycled,price,categoryTagId,brandTagId,description,const DeepCollectionEquality().hash(generalTagIds),imgPath,id);

@override
String toString() {
  return 'PartDto(name: $name, detailNumber: $detailNumber, isRecycled: $isRecycled, price: $price, categoryTagId: $categoryTagId, brandTagId: $brandTagId, description: $description, generalTagIds: $generalTagIds, imgPath: $imgPath, id: $id)';
}


}

/// @nodoc
abstract mixin class $PartDtoCopyWith<$Res>  {
  factory $PartDtoCopyWith(PartDto value, $Res Function(PartDto) _then) = _$PartDtoCopyWithImpl;
@useResult
$Res call({
 String name, String detailNumber, bool isRecycled, double price, String? categoryTagId, String? brandTagId, String? description, List<String> generalTagIds, String? imgPath, String? id
});




}
/// @nodoc
class _$PartDtoCopyWithImpl<$Res>
    implements $PartDtoCopyWith<$Res> {
  _$PartDtoCopyWithImpl(this._self, this._then);

  final PartDto _self;
  final $Res Function(PartDto) _then;

/// Create a copy of PartDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? detailNumber = null,Object? isRecycled = null,Object? price = null,Object? categoryTagId = freezed,Object? brandTagId = freezed,Object? description = freezed,Object? generalTagIds = null,Object? imgPath = freezed,Object? id = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,detailNumber: null == detailNumber ? _self.detailNumber : detailNumber // ignore: cast_nullable_to_non_nullable
as String,isRecycled: null == isRecycled ? _self.isRecycled : isRecycled // ignore: cast_nullable_to_non_nullable
as bool,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,categoryTagId: freezed == categoryTagId ? _self.categoryTagId : categoryTagId // ignore: cast_nullable_to_non_nullable
as String?,brandTagId: freezed == brandTagId ? _self.brandTagId : brandTagId // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,generalTagIds: null == generalTagIds ? _self.generalTagIds : generalTagIds // ignore: cast_nullable_to_non_nullable
as List<String>,imgPath: freezed == imgPath ? _self.imgPath : imgPath // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PartDto].
extension PartDtoPatterns on PartDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartDto value)  $default,){
final _that = this;
switch (_that) {
case _PartDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartDto value)?  $default,){
final _that = this;
switch (_that) {
case _PartDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String detailNumber,  bool isRecycled,  double price,  String? categoryTagId,  String? brandTagId,  String? description,  List<String> generalTagIds,  String? imgPath,  String? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartDto() when $default != null:
return $default(_that.name,_that.detailNumber,_that.isRecycled,_that.price,_that.categoryTagId,_that.brandTagId,_that.description,_that.generalTagIds,_that.imgPath,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String detailNumber,  bool isRecycled,  double price,  String? categoryTagId,  String? brandTagId,  String? description,  List<String> generalTagIds,  String? imgPath,  String? id)  $default,) {final _that = this;
switch (_that) {
case _PartDto():
return $default(_that.name,_that.detailNumber,_that.isRecycled,_that.price,_that.categoryTagId,_that.brandTagId,_that.description,_that.generalTagIds,_that.imgPath,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String detailNumber,  bool isRecycled,  double price,  String? categoryTagId,  String? brandTagId,  String? description,  List<String> generalTagIds,  String? imgPath,  String? id)?  $default,) {final _that = this;
switch (_that) {
case _PartDto() when $default != null:
return $default(_that.name,_that.detailNumber,_that.isRecycled,_that.price,_that.categoryTagId,_that.brandTagId,_that.description,_that.generalTagIds,_that.imgPath,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartDto extends PartDto {
  const _PartDto({required this.name, required this.detailNumber, required this.isRecycled, required this.price, required this.categoryTagId, required this.brandTagId, required this.description, required final  List<String> generalTagIds, required this.imgPath, this.id}): _generalTagIds = generalTagIds,super._();
  factory _PartDto.fromJson(Map<String, dynamic> json) => _$PartDtoFromJson(json);

@override final  String name;
@override final  String detailNumber;
@override final  bool isRecycled;
@override final  double price;
@override final  String? categoryTagId;
@override final  String? brandTagId;
@override final  String? description;
 final  List<String> _generalTagIds;
@override List<String> get generalTagIds {
  if (_generalTagIds is EqualUnmodifiableListView) return _generalTagIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_generalTagIds);
}

@override final  String? imgPath;
@override final  String? id;

/// Create a copy of PartDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartDtoCopyWith<_PartDto> get copyWith => __$PartDtoCopyWithImpl<_PartDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartDto&&(identical(other.name, name) || other.name == name)&&(identical(other.detailNumber, detailNumber) || other.detailNumber == detailNumber)&&(identical(other.isRecycled, isRecycled) || other.isRecycled == isRecycled)&&(identical(other.price, price) || other.price == price)&&(identical(other.categoryTagId, categoryTagId) || other.categoryTagId == categoryTagId)&&(identical(other.brandTagId, brandTagId) || other.brandTagId == brandTagId)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._generalTagIds, _generalTagIds)&&(identical(other.imgPath, imgPath) || other.imgPath == imgPath)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,detailNumber,isRecycled,price,categoryTagId,brandTagId,description,const DeepCollectionEquality().hash(_generalTagIds),imgPath,id);

@override
String toString() {
  return 'PartDto(name: $name, detailNumber: $detailNumber, isRecycled: $isRecycled, price: $price, categoryTagId: $categoryTagId, brandTagId: $brandTagId, description: $description, generalTagIds: $generalTagIds, imgPath: $imgPath, id: $id)';
}


}

/// @nodoc
abstract mixin class _$PartDtoCopyWith<$Res> implements $PartDtoCopyWith<$Res> {
  factory _$PartDtoCopyWith(_PartDto value, $Res Function(_PartDto) _then) = __$PartDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, String detailNumber, bool isRecycled, double price, String? categoryTagId, String? brandTagId, String? description, List<String> generalTagIds, String? imgPath, String? id
});




}
/// @nodoc
class __$PartDtoCopyWithImpl<$Res>
    implements _$PartDtoCopyWith<$Res> {
  __$PartDtoCopyWithImpl(this._self, this._then);

  final _PartDto _self;
  final $Res Function(_PartDto) _then;

/// Create a copy of PartDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? detailNumber = null,Object? isRecycled = null,Object? price = null,Object? categoryTagId = freezed,Object? brandTagId = freezed,Object? description = freezed,Object? generalTagIds = null,Object? imgPath = freezed,Object? id = freezed,}) {
  return _then(_PartDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,detailNumber: null == detailNumber ? _self.detailNumber : detailNumber // ignore: cast_nullable_to_non_nullable
as String,isRecycled: null == isRecycled ? _self.isRecycled : isRecycled // ignore: cast_nullable_to_non_nullable
as bool,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,categoryTagId: freezed == categoryTagId ? _self.categoryTagId : categoryTagId // ignore: cast_nullable_to_non_nullable
as String?,brandTagId: freezed == brandTagId ? _self.brandTagId : brandTagId // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,generalTagIds: null == generalTagIds ? _self._generalTagIds : generalTagIds // ignore: cast_nullable_to_non_nullable
as List<String>,imgPath: freezed == imgPath ? _self.imgPath : imgPath // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
