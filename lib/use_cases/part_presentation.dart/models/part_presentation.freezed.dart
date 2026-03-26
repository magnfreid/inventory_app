// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'part_presentation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PartPresentation {

 String get partId; String get name; String get detailNumber; double get price; bool get isRecycled; List<StockPresentation> get stock; TagPresentation? get categoryTag; TagPresentation? get brandTag; List<TagPresentation> get generalTags; String? get description; String? get imgPath;
/// Create a copy of PartPresentation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartPresentationCopyWith<PartPresentation> get copyWith => _$PartPresentationCopyWithImpl<PartPresentation>(this as PartPresentation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartPresentation&&(identical(other.partId, partId) || other.partId == partId)&&(identical(other.name, name) || other.name == name)&&(identical(other.detailNumber, detailNumber) || other.detailNumber == detailNumber)&&(identical(other.price, price) || other.price == price)&&(identical(other.isRecycled, isRecycled) || other.isRecycled == isRecycled)&&const DeepCollectionEquality().equals(other.stock, stock)&&(identical(other.categoryTag, categoryTag) || other.categoryTag == categoryTag)&&(identical(other.brandTag, brandTag) || other.brandTag == brandTag)&&const DeepCollectionEquality().equals(other.generalTags, generalTags)&&(identical(other.description, description) || other.description == description)&&(identical(other.imgPath, imgPath) || other.imgPath == imgPath));
}


@override
int get hashCode => Object.hash(runtimeType,partId,name,detailNumber,price,isRecycled,const DeepCollectionEquality().hash(stock),categoryTag,brandTag,const DeepCollectionEquality().hash(generalTags),description,imgPath);

@override
String toString() {
  return 'PartPresentation(partId: $partId, name: $name, detailNumber: $detailNumber, price: $price, isRecycled: $isRecycled, stock: $stock, categoryTag: $categoryTag, brandTag: $brandTag, generalTags: $generalTags, description: $description, imgPath: $imgPath)';
}


}

/// @nodoc
abstract mixin class $PartPresentationCopyWith<$Res>  {
  factory $PartPresentationCopyWith(PartPresentation value, $Res Function(PartPresentation) _then) = _$PartPresentationCopyWithImpl;
@useResult
$Res call({
 String partId, String name, String detailNumber, double price, bool isRecycled, List<StockPresentation> stock, TagPresentation? categoryTag, TagPresentation? brandTag, List<TagPresentation> generalTags, String? description, String? imgPath
});




}
/// @nodoc
class _$PartPresentationCopyWithImpl<$Res>
    implements $PartPresentationCopyWith<$Res> {
  _$PartPresentationCopyWithImpl(this._self, this._then);

  final PartPresentation _self;
  final $Res Function(PartPresentation) _then;

/// Create a copy of PartPresentation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? partId = null,Object? name = null,Object? detailNumber = null,Object? price = null,Object? isRecycled = null,Object? stock = null,Object? categoryTag = freezed,Object? brandTag = freezed,Object? generalTags = null,Object? description = freezed,Object? imgPath = freezed,}) {
  return _then(_self.copyWith(
partId: null == partId ? _self.partId : partId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,detailNumber: null == detailNumber ? _self.detailNumber : detailNumber // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,isRecycled: null == isRecycled ? _self.isRecycled : isRecycled // ignore: cast_nullable_to_non_nullable
as bool,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as List<StockPresentation>,categoryTag: freezed == categoryTag ? _self.categoryTag : categoryTag // ignore: cast_nullable_to_non_nullable
as TagPresentation?,brandTag: freezed == brandTag ? _self.brandTag : brandTag // ignore: cast_nullable_to_non_nullable
as TagPresentation?,generalTags: null == generalTags ? _self.generalTags : generalTags // ignore: cast_nullable_to_non_nullable
as List<TagPresentation>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imgPath: freezed == imgPath ? _self.imgPath : imgPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PartPresentation].
extension PartPresentationPatterns on PartPresentation {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String partId,  String name,  String detailNumber,  double price,  bool isRecycled,  List<StockPresentation> stock,  TagPresentation? categoryTag,  TagPresentation? brandTag,  List<TagPresentation> generalTags,  String? description,  String? imgPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Part() when $default != null:
return $default(_that.partId,_that.name,_that.detailNumber,_that.price,_that.isRecycled,_that.stock,_that.categoryTag,_that.brandTag,_that.generalTags,_that.description,_that.imgPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String partId,  String name,  String detailNumber,  double price,  bool isRecycled,  List<StockPresentation> stock,  TagPresentation? categoryTag,  TagPresentation? brandTag,  List<TagPresentation> generalTags,  String? description,  String? imgPath)  $default,) {final _that = this;
switch (_that) {
case _Part():
return $default(_that.partId,_that.name,_that.detailNumber,_that.price,_that.isRecycled,_that.stock,_that.categoryTag,_that.brandTag,_that.generalTags,_that.description,_that.imgPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String partId,  String name,  String detailNumber,  double price,  bool isRecycled,  List<StockPresentation> stock,  TagPresentation? categoryTag,  TagPresentation? brandTag,  List<TagPresentation> generalTags,  String? description,  String? imgPath)?  $default,) {final _that = this;
switch (_that) {
case _Part() when $default != null:
return $default(_that.partId,_that.name,_that.detailNumber,_that.price,_that.isRecycled,_that.stock,_that.categoryTag,_that.brandTag,_that.generalTags,_that.description,_that.imgPath);case _:
  return null;

}
}

}

/// @nodoc


class _Part extends PartPresentation {
  const _Part({required this.partId, required this.name, required this.detailNumber, required this.price, required this.isRecycled, final  List<StockPresentation> stock = const [], this.categoryTag, this.brandTag, final  List<TagPresentation> generalTags = const [], this.description, this.imgPath}): _stock = stock,_generalTags = generalTags,super._();
  

@override final  String partId;
@override final  String name;
@override final  String detailNumber;
@override final  double price;
@override final  bool isRecycled;
 final  List<StockPresentation> _stock;
@override@JsonKey() List<StockPresentation> get stock {
  if (_stock is EqualUnmodifiableListView) return _stock;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stock);
}

@override final  TagPresentation? categoryTag;
@override final  TagPresentation? brandTag;
 final  List<TagPresentation> _generalTags;
@override@JsonKey() List<TagPresentation> get generalTags {
  if (_generalTags is EqualUnmodifiableListView) return _generalTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_generalTags);
}

@override final  String? description;
@override final  String? imgPath;

/// Create a copy of PartPresentation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartCopyWith<_Part> get copyWith => __$PartCopyWithImpl<_Part>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Part&&(identical(other.partId, partId) || other.partId == partId)&&(identical(other.name, name) || other.name == name)&&(identical(other.detailNumber, detailNumber) || other.detailNumber == detailNumber)&&(identical(other.price, price) || other.price == price)&&(identical(other.isRecycled, isRecycled) || other.isRecycled == isRecycled)&&const DeepCollectionEquality().equals(other._stock, _stock)&&(identical(other.categoryTag, categoryTag) || other.categoryTag == categoryTag)&&(identical(other.brandTag, brandTag) || other.brandTag == brandTag)&&const DeepCollectionEquality().equals(other._generalTags, _generalTags)&&(identical(other.description, description) || other.description == description)&&(identical(other.imgPath, imgPath) || other.imgPath == imgPath));
}


@override
int get hashCode => Object.hash(runtimeType,partId,name,detailNumber,price,isRecycled,const DeepCollectionEquality().hash(_stock),categoryTag,brandTag,const DeepCollectionEquality().hash(_generalTags),description,imgPath);

@override
String toString() {
  return 'PartPresentation(partId: $partId, name: $name, detailNumber: $detailNumber, price: $price, isRecycled: $isRecycled, stock: $stock, categoryTag: $categoryTag, brandTag: $brandTag, generalTags: $generalTags, description: $description, imgPath: $imgPath)';
}


}

/// @nodoc
abstract mixin class _$PartCopyWith<$Res> implements $PartPresentationCopyWith<$Res> {
  factory _$PartCopyWith(_Part value, $Res Function(_Part) _then) = __$PartCopyWithImpl;
@override @useResult
$Res call({
 String partId, String name, String detailNumber, double price, bool isRecycled, List<StockPresentation> stock, TagPresentation? categoryTag, TagPresentation? brandTag, List<TagPresentation> generalTags, String? description, String? imgPath
});




}
/// @nodoc
class __$PartCopyWithImpl<$Res>
    implements _$PartCopyWith<$Res> {
  __$PartCopyWithImpl(this._self, this._then);

  final _Part _self;
  final $Res Function(_Part) _then;

/// Create a copy of PartPresentation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? partId = null,Object? name = null,Object? detailNumber = null,Object? price = null,Object? isRecycled = null,Object? stock = null,Object? categoryTag = freezed,Object? brandTag = freezed,Object? generalTags = null,Object? description = freezed,Object? imgPath = freezed,}) {
  return _then(_Part(
partId: null == partId ? _self.partId : partId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,detailNumber: null == detailNumber ? _self.detailNumber : detailNumber // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,isRecycled: null == isRecycled ? _self.isRecycled : isRecycled // ignore: cast_nullable_to_non_nullable
as bool,stock: null == stock ? _self._stock : stock // ignore: cast_nullable_to_non_nullable
as List<StockPresentation>,categoryTag: freezed == categoryTag ? _self.categoryTag : categoryTag // ignore: cast_nullable_to_non_nullable
as TagPresentation?,brandTag: freezed == brandTag ? _self.brandTag : brandTag // ignore: cast_nullable_to_non_nullable
as TagPresentation?,generalTags: null == generalTags ? _self._generalTags : generalTags // ignore: cast_nullable_to_non_nullable
as List<TagPresentation>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imgPath: freezed == imgPath ? _self.imgPath : imgPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
