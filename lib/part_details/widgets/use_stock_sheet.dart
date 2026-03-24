import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:inventory_app/shared/extensions/show_snack_bar_extensions.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';

class UseStockSheet extends StatefulWidget {
  const UseStockSheet({required this.partName, required this.stock, super.key});

  final StockPresentation stock;
  final String partName;

  @override
  State<UseStockSheet> createState() => _UseStockSheetState();
}

class _UseStockSheetState extends State<UseStockSheet> {
  late final TextEditingController _controller;
  bool canSave = false;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsetsBottom = MediaQuery.of(context).viewInsets.bottom;
    final userId = context.read<UserCubit>().state.maybeWhen(
      loaded: (user) => user.id,
      orElse: () => null,
    );
    final l10n = context.l10n;
    return BlocListener<PartDetailsBloc, PartDetailsState>(
      listenWhen: (previous, current) => current.saveStatus == .done,
      listener: (context, state) {
        final error = state.error;
        if (error != null) context.showErrorSnackBar(error);
        Navigator.pop(context);
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: .fromLTRB(24, 8, 24, viewInsetsBottom + 36),
          child: Column(
            mainAxisSize: .min,
            children: [
              //TODO(magnfreid): Add l10n!
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      style: context.text.bodyLarge, // default style
                      children: [
                        const TextSpan(text: 'Use one '),
                        TextSpan(
                          text: widget.partName,
                          style: TextStyle(
                            color: context.colors.secondary,
                          ),
                        ),
                        const TextSpan(text: ' from '),
                        TextSpan(
                          text: widget.stock.storageName,
                          style: TextStyle(
                            color: context.colors.tertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                maxLines: 3,
                minLines: 1,
                maxLength: 100,
                decoration: const InputDecoration(
                  hint: Text('Enter message...'),
                  label: Text('Message'),
                ),
                controller: _controller,
                onChanged: (value) =>
                    setState(() => canSave = _controller.text.isNotEmpty),
              ),
              const SizedBox(height: 16),
              BlocBuilder<PartDetailsBloc, PartDetailsState>(
                builder: (context, state) {
                  return AppButton(
                    isLoading: state.saveStatus == .loading,
                    onPressed: canSave && userId != null
                        ? () => context.read<PartDetailsBloc>().add(
                            UseButtonPressed(
                              userId: userId,
                              message: _controller.text,
                              storageId: widget.stock.storageId,
                            ),
                          )
                        : null,
                    label: l10n.saveButtonText,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
