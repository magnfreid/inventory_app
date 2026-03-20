import 'package:core_remote/core_remote.dart';
import 'package:flutter/widgets.dart';
import 'package:inventory_app/l10n/gen/app_localizations.dart';

export 'package:inventory_app/l10n/gen/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension RemoteExceptionToL10n on RemoteException {
  String toL10n(BuildContext context) => switch (this) {
    PermissionDeniedException() => context.l10n.remoteExceptionPermissionDenied,
    NotFoundException() => context.l10n.remoteExceptionNotFound,
    AlreadyExistsException() => context.l10n.remoteExceptionAlreadyExists,
    NetworkException() => context.l10n.remoteExceptionNetwork,
    TimeoutException() => context.l10n.remoteExceptionTimeout,
    UnknownRemoteException() => context.l10n.remoteExceptionUnknown,
    InvalidArgumentRemoteException() =>
      context.l10n.remoteExceptionInvalidArgument,
  };
}
