import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_item_details_event.dart';

class InventoryItemDetailsBloc
    extends Bloc<InventoryItemDetailsEvent, InventoryItemDetailsState> {
  InventoryItemDetailsBloc() : super(_Initial()) {
    on<InventoryItemDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
