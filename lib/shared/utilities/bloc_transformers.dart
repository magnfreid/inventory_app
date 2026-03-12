import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

/// Returns an [EventTransformer] that **debounces incoming events**.
///
/// Debouncing waits until no new events have been emitted for the
/// specified [duration] before forwarding the latest event to the handler.
///
/// This is commonly used for:
/// - search input
/// - text field filtering
/// - preventing frequent network requests while typing
///
/// Example:
/// ```dart
/// on<SearchQueryChanged>(
///   _onSearchQueryChanged,
///   transformer: debounce(const Duration(milliseconds: 300)),
/// );
/// ```
///
/// Behavior:
/// ```text
/// User types:  A  AB  ABC
///              │  │   │
///              └──┴───┴── wait 300ms
///                      ↓
///                   ABC processed
/// ```
EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

/// Returns an [EventTransformer] that **throttles events**.
///
/// Throttling allows **only one event to pass within each [duration] window**.
/// Any additional events emitted during that time are ignored.
///
/// Useful for:
/// - scroll events
/// - rapid button taps
/// - analytics or logging events
/// - preventing repeated expensive operations
///
/// Example:
/// ```dart
/// on<ScrollEvent>(
///   _onScroll,
///   transformer: throttle(const Duration(milliseconds: 500)),
/// );
/// ```
///
/// Behavior:
/// ```text
/// Events:  A B C D E
///
/// Throttle 500ms:
/// A ---- wait ---- D
/// ```
EventTransformer<Event> throttle<Event>(Duration duration) {
  return (events, mapper) => events.throttleTime(duration).flatMap(mapper);
}

/// Returns an [EventTransformer] that combines **debounce + restartable behavior**.
///
/// First, events are **debounced** for the specified [duration].
/// Then, if a new event arrives while the previous handler is still running,
/// the previous handler is **cancelled and replaced by the new one**.
///
/// Internally this uses `switchMap`, which ensures only the **latest event**
/// continues processing.
///
/// This pattern is ideal for:
/// - search queries
/// - filtering large lists
/// - auto-complete requests
///
/// Example:
/// ```dart
/// on<SearchQueryChanged>(
///   _onSearchQueryChanged,
///   transformer: debounceRestartable(const Duration(milliseconds: 300)),
/// );
/// ```
///
/// Behavior:
/// ```text
/// User typing:
/// A
/// AB
/// ABC
///
/// wait 300ms
/// ↓
/// Only "ABC" triggers the handler
///
/// If another query appears while the request is running,
/// the previous request is cancelled.
/// ```
EventTransformer<Event> debounceRestartable<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}
