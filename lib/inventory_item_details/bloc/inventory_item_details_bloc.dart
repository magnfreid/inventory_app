import 'package:bloc/bloc.dart';
import 'package:inventory_app/inventory_item_details/bloc/inventory_item_details_state.dart';

part 'inventory_item_details_event.dart';

class InventoryItemDetailsBloc
    extends Bloc<InventoryItemDetailsEvent, InventoryItemDetailsState> {
  InventoryItemDetailsBloc() : super(const InventoryItemDetailsState()) {
    on<InventoryItemDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
