import 'package:core_remote/core_remote.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/shared/widgets/app_snack_bar.dart';

extension ShowSnackBar on BuildContext {
  /// Shows a success snackbar with [message].
  void showSuccessSnackBar(String message) =>
      showAppSnackBar(this, message, .success);

  /// Shows an error snackbar.
  ///
  /// [exception] is mapped to a localized string when it is a
  /// [RemoteException]; otherwise falls back to [Exception.toString].
  void showErrorSnackBar(Exception exception) {
    final message = exception is RemoteException
        ? exception.toL10n(this)
        : exception.toString();
    showAppSnackBar(this, message, .error);
  }
}
