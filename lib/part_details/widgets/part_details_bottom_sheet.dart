import 'package:flutter/material.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:storage_repository/storage_repository.dart';

class PartDetailsBottomSheet extends StatefulWidget {
  const PartDetailsBottomSheet({
    required this.amount,
    required this.storage,
    required this.onPressed,
    super.key,
  });

  final Storage storage;
  final int amount;
  final void Function(int amount) onPressed;

  @override
  State<PartDetailsBottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<PartDetailsBottomSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.amount.toString());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        Text(l10n.addStockTitleText),
        Row(
          children: [
            Text(widget.storage.name),
            Expanded(
              child: TextField(
                controller: _controller,
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            final quantity = int.tryParse(
              _controller.text,
            );
            if (quantity == null || quantity == 0) return;
            widget.onPressed(quantity);
          },
          child: Text(l10n.saveButtonText),
        ),
      ],
    );
  }
}
