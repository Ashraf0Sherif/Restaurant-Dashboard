import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.borderRadius,
      required this.textColor,
      required this.backgroundColor,
      required this.text,
      this.fontSize,
      required this.onPressed});

  final BorderRadiusGeometry borderRadius;
  final Color textColor, backgroundColor;
  final String text;
  final double? fontSize;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}
