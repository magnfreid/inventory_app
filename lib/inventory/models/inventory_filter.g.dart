// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryFilter _$InventoryFilterFromJson(Map<String, dynamic> json) =>
    InventoryFilter(
      quantityFilter:
          $enumDecodeNullable(
            _$QuantityFilterEnumMap,
            json['quantityFilter'],
          ) ??
          .all,
      brandFilters:
          (json['brandFilters'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      categoryFilters:
          (json['categoryFilters'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      storageFilters:
          (json['storageFilters'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      generalTagFilters:
          (json['generalTagFilters'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      sortByType:
          $enumDecodeNullable(_$SortByTypeEnumMap, json['sortByType']) ?? .name,
      isSortedAscending: json['isSortedAscending'] as bool? ?? true,
    );

Map<String, dynamic> _$InventoryFilterToJson(InventoryFilter instance) =>
    <String, dynamic>{
      'quantityFilter': _$QuantityFilterEnumMap[instance.quantityFilter]!,
      'brandFilters': instance.brandFilters.toList(),
      'categoryFilters': instance.categoryFilters.toList(),
      'storageFilters': instance.storageFilters.toList(),
      'generalTagFilters': instance.generalTagFilters.toList(),
      'sortByType': _$SortByTypeEnumMap[instance.sortByType]!,
      'isSortedAscending': instance.isSortedAscending,
    };

const _$QuantityFilterEnumMap = {
  QuantityFilter.all: 'all',
  QuantityFilter.inStock: 'inStock',
};

const _$SortByTypeEnumMap = {
  SortByType.name: 'name',
  SortByType.brand: 'brand',
  SortByType.category: 'category',
  SortByType.quantity: 'quantity',
};
