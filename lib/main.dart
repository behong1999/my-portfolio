import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:web_portfolio/theme/theme_model.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'pages/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer(
        builder: (context, ThemeModel themeNotifier, _) {
          // final themeMode = themeNotifier.themeMode;
          final isDark = themeNotifier.isDark;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'My Portfolio',
            theme: isDark ? darkTheme(context) : lightTheme(context),
            builder: (context, child) => ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, child ?? const SizedBox()),
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(480, name: MOBILE),
                const ResponsiveBreakpoint.resize(800, name: TABLET),
                const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                const ResponsiveBreakpoint.resize(2460, name: "4K"),
              ],
            ),
            home: const Home(),
          );
        },
      ),
    );
  }
}
