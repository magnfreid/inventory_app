import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';

class DeletePartSheet extends StatelessWidget {
  const DeletePartSheet({
    required this.partId,
    super.key,
  });

  final String partId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const .all(24),
      child: Column(
        spacing: 20,
        mainAxisSize: .min,
        children: [
          Text(
            l10n.deletePartSheetTitleText,
            style: context.text.bodyLarge,
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              AppButton.elevated(
                width: .wrap,
                onPressed: () => Navigator.pop(context),
                label: l10n.cancel,
              ),
              BlocBuilder<PartDetailsBloc, PartDetailsState>(
                builder: (context, state) {
                  return AppButton(
                    isLoading: state.deleteStatus == .loading,
                    onPressed: () => context.read<PartDetailsBloc>().add(
                      ConfirmDeletePartButtonPressed(partId: partId),
                    ),
                    label: l10n.delete,
                    buttonStyle: ElevatedButton.styleFrom(
                      backgroundColor: context.colors.error,
                    ),
                    textStyle: context.text.bodyMedium?.copyWith(
                      color: context.colors.onError,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
