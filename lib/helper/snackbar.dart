import 'package:flutter/material.dart';
import '../widgets/snackbar_message.dart';

snackbar(BuildContext context, String message, bool isError) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    width: 300,
    elevation: 0,
    backgroundColor: const Color(0xFF323437),
    behavior: SnackBarBehavior.floating,
    content: SnackBarMessage(
      isError: isError,
      message: message,
    ),
  ));
}
