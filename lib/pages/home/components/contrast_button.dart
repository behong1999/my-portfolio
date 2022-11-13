import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_portfolio/theme/theme_model.dart';
import 'package:web_portfolio/utils/constants.dart';

class ContrastButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, _) {
      return CircleAvatar(
        radius: 25,
        backgroundColor: mColor,
        child: IconButton(
          splashColor: mColor.withOpacity(0.5),
          hoverColor: Colors.transparent,
          onPressed: () {
            themeNotifier.switchTheme();
          },
          color: dCaptionColor,
          icon: Icon(
            themeNotifier.isDark ? Icons.brightness_high : Icons.nightlight,
          ),
        ),
      );
    });
  }
}
