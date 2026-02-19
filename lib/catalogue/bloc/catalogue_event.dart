part of 'catalogue_bloc.dart';

sealed class CatalogueEvent {
  const CatalogueEvent();
}

final class _OnCatalogueItemsChanged extends CatalogueEvent {
  const _OnCatalogueItemsChanged({required this.updates});
  final List<CatalogueItem> updates;
}

final class SaveButtonPressed extends CatalogueEvent {
  const SaveButtonPressed({required this.item});
  final CatalogueItem item;
}
