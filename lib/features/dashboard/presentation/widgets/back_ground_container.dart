import 'package:flutter/material.dart';

class BackGroundContainer extends StatelessWidget {
  const BackGroundContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
  });
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
