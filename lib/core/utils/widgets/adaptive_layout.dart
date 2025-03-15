import 'dart:developer';

import 'package:flutter/material.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout(
      {super.key,
      required this.mobileLayout,
      required this.tabletLayout,
      required this.desktopLayout,
      this.mobileMaxWidth = 760,
      this.tabletMaxWidth = 1200});
  final WidgetBuilder mobileLayout, tabletLayout, desktopLayout;
  final double mobileMaxWidth, tabletMaxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        log(constraints.maxWidth.toString());
        if (constraints.maxWidth < mobileMaxWidth) {
          return mobileLayout(context);
        } else if (constraints.maxWidth < tabletMaxWidth) {
          return tabletLayout(context);
        } else {
          return desktopLayout(context);
        }
      },
    );
  }
}
