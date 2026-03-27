import 'package:app_ui/app_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PartDetailsImage extends StatelessWidget {
  const PartDetailsImage({required this.onAddImagePressed, super.key});

  final VoidCallback onAddImagePressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<PartDetailsBloc, PartDetailsState>(
      buildWhen: (previous, current) =>
          previous.imageStatusLoading != current.imageStatusLoading ||
          previous.part.imgPath != current.part.imgPath,
      builder: (context, state) {
        final imagePath = state.part.imgPath;
        return state.imageStatus == .loading
            ? const _ImageFrame(
                child: Center(child: CircularProgressIndicator.adaptive()),
              )
            : switch (imagePath) {
                String() => _ImageFrame(
                  hideBorder: true,
                  child: CachedNetworkImage(
                    imageUrl: imagePath,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Shimmer(
                      duration: const Duration(seconds: 4),
                      color: context.colors.onSurface,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: .circular(6),
                          color: context.colors.surface,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Column(
                        mainAxisSize: .min,
                        children: [
                          const Icon(Icons.image_not_supported),
                          Text(l10n.partDetailsImageNotLoaded),
                        ],
                      ),
                    ),
                  ),
                ),
                null => _ImageFrame(
                  child: Center(
                    child: TextButton.icon(
                      icon: const Icon(Icons.add),
                      onPressed: onAddImagePressed,
                      label: Text(l10n.partDetailsAddImage),
                    ),
                  ),
                ),
              };
      },
    );
  }
}

class _ImageFrame extends StatelessWidget {
  const _ImageFrame({required this.child, this.hideBorder = false});

  final Widget child;
  final bool hideBorder;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: hideBorder
            ? null
            : BoxDecoration(
                border: .all(color: context.colors.onSurface, width: 0.5),
                borderRadius: .circular(6),
              ),
        child: child,
      ),
    );
  }
}
