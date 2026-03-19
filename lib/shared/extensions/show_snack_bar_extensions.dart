import 'package:core_remote/core_remote.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/l10n/l10n.dart';

extension ShowSnackBar on BuildContext {
  void showErrorSnackBar(Exception exception) {
    final message = (exception is RemoteException)
        ? exception.toL10n(this)
        : exception.toString();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }
}
