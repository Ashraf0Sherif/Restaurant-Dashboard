import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/adaptive_layout.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/mobile_layout.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: MobileLayout(),

      //   AdaptiveLayout(
      //     mobileLayout: (context) {
      //       return const MobileLayout();
      //     },
      //     tabletLayout: (context) {
      //       return Text('Tablet');
      //     },
      //     desktopLayout: (context) {
      //       return Text('Desktop');
      //     },
      //   ),
      // ),
    ));
  }
}
