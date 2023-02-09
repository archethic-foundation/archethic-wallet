import 'package:flutter/material.dart';

class ResultSnackbar extends SnackBar {
  ResultSnackbar({
    super.key,
    required String prefix,
    required String message,
    required Color color,
  }) : super(
          duration: const Duration(seconds: 15),
          backgroundColor: color,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(prefix),
              Text(message),
            ],
          ),
        );

  factory ResultSnackbar.success(String message) => ResultSnackbar(
        prefix: "Success :",
        message: message,
        color: Colors.green,
      );

  factory ResultSnackbar.error(String message) => ResultSnackbar(
        prefix: "Error :",
        message: message,
        color: Colors.red,
      );
}
