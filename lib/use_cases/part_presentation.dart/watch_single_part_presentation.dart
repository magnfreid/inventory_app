import 'package:collection/collection.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_part_presentations.dart';

class WatchSinglePartPresentation {
  WatchSinglePartPresentation({
    required WatchPartPresentations watchPartPresentations,
  }) : _watchPartPresentations = watchPartPresentations;

  final WatchPartPresentations _watchPartPresentations;

  Stream<PartPresentation?> call(String partId) {
    return _watchPartPresentations().map((parts) {
      return parts.firstWhereOrNull((part) => part.partId == partId);
    });
  }
}
