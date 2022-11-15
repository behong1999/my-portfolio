// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:web_portfolio/gen/assets.gen.dart';
import 'package:web_portfolio/models/header_item.dart';
import 'package:web_portfolio/pages/home/components/contrast_button.dart';
import 'package:web_portfolio/pages/home/home.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/globals.dart';

List<HeaderItem> headerItems = [
  HeaderItem(
    title: "HOME",
    onTap: () => scrollTo(0),
  ),
  HeaderItem(
    title: "PROJECTS",
    onTap: () => scrollTo(7),
  ),
  HeaderItem(
    title: "TESTIMONIALS",
    onTap: () => scrollTo(11),
  ),
  HeaderItem(
    title: "CONTACT",
    onTap: () => scrollTo(componentsList.length),
  ),
  // HeaderItem(title: "HIRE ME", onTap: () {}, isButton: true),
];

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          child: Image.asset(
            Assets.logo.path,
            fit: BoxFit.cover,
          ),
          onTap: () {
            scrollTo(0);
          },
        ),
      ),
    );
  }
}

class Header extends StatefulWidget {
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Color? textColor;
  int? currentIndex;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        children: [
          desktopTabletHeader(),
          mobileHeader(),
        ],
      ),
    );
  }

  ResponsiveVisibility mobileHeader() {
    return ResponsiveVisibility(
        visible: false,
        visibleWhen: const [
          Condition.equals(name: MOBILE),
          Condition.smallerThan(name: MOBILE),
        ],
        child: Row(
          children: [
            ContrastButton(),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                //*  Open drawer using global key
                Globals.scaffoldKey.currentState!.openEndDrawer();
              },
              child: const Icon(
                FlutterIcons.menu_fea,
                size: 28.0,
              ),
            ),
          ],
        ));
  }

  ResponsiveVisibility desktopTabletHeader() {
    return ResponsiveVisibility(
      visible: false,
      visibleWhen: const [Condition.largerThan(name: MOBILE)],
      child: Row(
        children: [
          ...headerItems
              .map(
                (item) => MouseRegion(
                  onHover: (event) {
                    setState(() {
                      textColor = mColor;
                      currentIndex = headerItems.indexOf(item);
                    });
                  },
                  onExit: (event) {
                    setState(() {
                      textColor = null;
                    });
                  },
                  cursor: SystemMouseCursors.click,
                  child: AnimatedContainer(
                    duration: const Duration(
                      seconds: 1,
                    ),
                    margin: const EdgeInsets.only(right: 30.0),
                    child: GestureDetector(
                      onTap: () {
                        item.onTap();
                      },
                      child: Text(
                        item.title,
                        style: TextStyle(
                          color: currentIndex == headerItems.indexOf(item)
                              ? textColor
                              : null,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          ContrastButton()
        ],
      ),
    );
  }
}
