import 'package:collection/collection.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_part_presentations.dart';

/// Returns a stream for a single [PartPresentation] identified by a part ID.
///
/// Delegates to [WatchPartPresentations], which multicasts one shared Firestore
/// subscription across all callers. Each emission of the full parts list is
/// filtered down to the requested part, so this stream updates whenever
/// anything in the inventory changes. The null case occurs if the part is
/// deleted.
class WatchSinglePartPresentation {
  /// Creates a [WatchSinglePartPresentation] use case.
  WatchSinglePartPresentation({
    required WatchPartPresentations watchPartPresentations,
  }) : _watchPartPresentations = watchPartPresentations;

  final WatchPartPresentations _watchPartPresentations;

  /// Emits the [PartPresentation] for [partId], or null if it no longer
  /// exists. Shares the underlying stream with all other callers of
  /// [WatchPartPresentations].
  Stream<PartPresentation?> call(String partId) {
    return _watchPartPresentations().map(
      (parts) => parts.firstWhereOrNull((part) => part.partId == partId),
    );
  }
}
