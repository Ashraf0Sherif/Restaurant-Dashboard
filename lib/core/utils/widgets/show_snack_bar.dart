import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all( Radius.circular(4)),
        side: BorderSide(color: Colors.black,width: 1.4),
      ),
      backgroundColor: Colors.black87,
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
