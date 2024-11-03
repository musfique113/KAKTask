import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String status,
    {bool isError = false}) {
  final snackBar = SnackBar(
    content: Text(
      status,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: isError ? Colors.redAccent : Colors.greenAccent,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
