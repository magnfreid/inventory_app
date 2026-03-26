import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';

class DeleteImageSheet extends StatelessWidget {
  const DeleteImageSheet({
    required this.part,
    super.key,
  });

  final PartPresentation part;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<PartDetailsBloc, PartDetailsState>(
      listenWhen: (previous, current) =>
          previous.imageStatus != current.imageStatus &&
          current.imageStatus == .done,
      listener: (context, state) {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const .all(24),
        child: Column(
          spacing: 20,
          mainAxisSize: .min,
          children: [
            Text(
              'Delete image?',
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
                      isLoading: state.imageStatus == .loading,
                      onPressed: () => context.read<PartDetailsBloc>().add(
                        ConfirmDeleteImageButtonPressed(part: part),
                      ),
                      label: l10n.delete,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
