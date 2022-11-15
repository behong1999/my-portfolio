import 'package:flutter/material.dart';
import 'package:web_portfolio/utils/constants.dart';

class ScreenHelper extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ScreenHelper({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < kTabletMaxWidth;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= kTabletMaxWidth &&
      MediaQuery.of(context).size.width < kDesktopMaxWidth;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= kDesktopMaxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth >= kDesktopMaxWidth) {
          return desktop;
        } else if (constraints.maxWidth >= kTabletMaxWidth &&
            constraints.maxWidth < kDesktopMaxWidth) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
