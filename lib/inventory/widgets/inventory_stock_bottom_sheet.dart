import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/shared/widgets/in_stock_panel.dart';
import 'package:inventory_app/shared/widgets/stock_list_tile.dart';
import 'package:inventory_app/shared/widgets/use_stock_checkout.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';

class InventoryQuickStockBottomSheet extends StatelessWidget {
  const InventoryQuickStockBottomSheet({required this.part, super.key});

  final PartPresentation part;

  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalKey<NavigatorState>();
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (_) => InStockPanel.route(
        part: part,
        onPressed: (stock) => navigatorKey.currentState?.push(
          UseStockCheckout.route(stock: stock),
        ),
      ),
    );
  }
}

// class _StorageSelector extends StatelessWidget {
//   const _StorageSelector({required this.part, super.key});

//   final PartPresentation part;

//   static MaterialPageRoute<void> route({required PartPresentation part}) =>
//       MaterialPageRoute(
//         builder: (context) => _StorageSelector(part: part),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<InventoryBloc, InventoryState>(
//       buildWhen: (previous, current) =>
//           previous.bottomSheetStatus != current.bottomSheetStatus,
//       builder: (context, state) {
//         final stocks = part.stock.where((stock) => stock.quantity > 0).toList();
//         return Scaffold(
//           body: Padding(
//             padding: const .all(24),
//             child: Column(
//               crossAxisAlignment: .start,
//               children: [
//                 Padding(
//                   padding: const .fromLTRB(8, 0, 0, 10),
//                   child: Column(
//                     crossAxisAlignment: .start,
//                     children: [
//                       Text(
//                         part.name,
//                         style: context.text.titleLarge,
//                       ),
//                       Text(
//                         part.detailNumber,
//                         style: context.text.titleMedium?.copyWith(
//                           color: context.colors.onSurfaceVariant,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Divider(color: context.colors.secondary),
//                 ListView.separated(
//                   separatorBuilder: (context, index) => const Divider(
//                     thickness: 0.5,
//                   ),
//                   shrinkWrap: true,
//                   itemCount: stocks.length,
//                   itemBuilder: (context, index) {
//                     final stock = stocks[index];
//                     return StockListTile(
//                       stock: stock,
//                       onPressed: () => Navigator.push(
//                         context,
//                         _NoteInput.route(stock: stock),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _NoteInput extends StatelessWidget {
//   const _NoteInput({required this.stock});

//   static MaterialPageRoute<void> route({required StockPresentation stock}) =>
//       MaterialPageRoute(builder: (context) => _NoteInput(stock: stock));

//   final StockPresentation stock;

//   @override
//   Widget build(BuildContext context) {
//     final l10n = context.l10n;
//     return Scaffold(
//       body: Padding(
//         padding: const .all(24),
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   spacing: 10,
//                   children: [
//                     Stack(
//                       alignment: .center,
//                       children: [
//                         const Align(
//                           alignment: .centerLeft,
//                           child: BackButton(),
//                         ),
//                         Text(
//                           stock.storageName,
//                           style: context.text.titleLarge,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 24),
//                     Row(
//                       spacing: 20,
//                       children: [
//                         Text(
//                           '${l10n.partDetailsSelectorInStock}:',
//                           style: context.text.bodyLarge,
//                         ),
//                         Text(
//                           stock.quantity.toString(),
//                           style: context.text.bodyLarge?.copyWith(
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ],
//                     ),
//                     TextFormField(
//                       maxLength: 40,
//                       //TODO(magnfreid): Add l10n
//                       decoration: const InputDecoration(label: Text('Notes')),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             AppButton(
//               onPressed: () {},
//               label: l10n.inStockUseButtonLabelText,
//             ),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }
// }
