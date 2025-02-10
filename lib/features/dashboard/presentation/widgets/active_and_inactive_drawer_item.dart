import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';

class ActiveMenuItem extends StatefulWidget {
  final IconData icon;
  final String data;
  final void Function() onTap;

  const ActiveMenuItem({
    super.key,
    required this.icon,
    required this.data,
    required this.onTap,
  });

  @override
  State<ActiveMenuItem> createState() => _ActiveMenuItemState();
}

class _ActiveMenuItemState extends State<ActiveMenuItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<double>(
      begin: -20.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_slideAnimation.value, 0),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: const BoxDecoration(
                color: ColorsStyles.kPrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: InkWell(
                onTap: widget.onTap,
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 10),
                  leading: Icon(
                    widget.icon,
                    color: Colors.white,
                  ),
                  title: Text(
                    widget.data,
                    style: TextStyle(
                      fontSize: FontStyles.getResponsiveFontSize(context, 18),
                      color: Colors.white,
                    ),
                  ),
                  trailing: Container(
                    width: 3.27,
                    decoration: BoxDecoration(
                      color: ColorsStyles.kSecondaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class InactiveMenuItem extends StatefulWidget {
  final IconData icon;
  final String data;
  final void Function() onTap;

  const InactiveMenuItem({
    super.key,
    required this.icon,
    required this.data,
    required this.onTap,
  });

  @override
  State<InactiveMenuItem> createState() => _InactiveMenuItemState();
}

class _InactiveMenuItemState extends State<InactiveMenuItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<double>(
      begin: 20.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_slideAnimation.value, 0),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: widget.onTap,
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 10),
                  leading: Icon(
                    widget.icon,
                    color: Colors.white,
                  ),
                  title: Text(
                    widget.data,
                    style: TextStyle(
                      fontSize: FontStyles.getResponsiveFontSize(context, 18),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
