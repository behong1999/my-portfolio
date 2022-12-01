import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:web_portfolio/pages/home/components/carousel.dart';
import 'package:web_portfolio/pages/home/components/contact_section.dart';
import 'package:web_portfolio/pages/home/components/cv_section.dart';
import 'package:web_portfolio/pages/home/components/footer.dart';
import 'package:web_portfolio/pages/home/components/header.dart';
import 'package:web_portfolio/pages/home/components/pokedex_ad.dart';
import 'package:web_portfolio/pages/home/components/skill_section.dart';
import 'package:web_portfolio/pages/home/components/stock_market_ad.dart';
import 'package:web_portfolio/pages/home/components/testimonial_section.dart';
import 'package:web_portfolio/theme/theme_model.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/globals.dart';

final itemScrollController = ItemScrollController();
final itemPositionsListener = ItemPositionsListener.create();

scrollTo(int index) {
  itemScrollController.jumpTo(
    index: index,
    alignment: 0.85,
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color? textColor;
  int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: Consumer(
        builder: (context, ThemeModel themeNotifier, _) => Scaffold(
          resizeToAvoidBottomInset: false,
          endDrawer: Drawer(
            backgroundColor:
                themeNotifier.isDark ? dBackgroundColor : lBackgroundColor,
            width: MediaQuery.of(context).size.width * 0.30,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    final item = headerItems[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
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
                          child: AnimatedContainer(
                            duration: const Duration(
                              seconds: 1,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: GestureDetector(
                              onTap: () {
                                item.onTap();
                                setState(() {
                                  textColor = null;
                                  currentIndex = null;
                                });
                                Timer(
                                  const Duration(milliseconds: 200),
                                  () => Globals.scaffoldKey.currentState!
                                      .closeEndDrawer(),
                                );
                              },
                              child: Text(
                                item.title,
                                style: TextStyle(
                                  color:
                                      currentIndex == headerItems.indexOf(item)
                                          ? textColor
                                          : null,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 1,
                      height: 10,
                    );
                  },
                  itemCount: headerItems.length,
                ),
              ),
            ),
          ),
          key: Globals.scaffoldKey,
          body: NestedScrollView(
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                toolbarHeight: MediaQuery.of(context).size.height * 0.12,
                leading: Logo(),
                leadingWidth: 88,
                actions: [Header()],
              ),
            ],
            body: ScrollablePositionedList.builder(
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              itemCount: componentsList.length,
              itemBuilder: (context, int index) {
                return componentsList[index];
              },
            ),
          ),
        ),
      ),
    );
  }
}

final componentsList = [
  const SizedBox(height: 20),
  Carousel(),
  const SizedBox(height: 60),
  SkillSection(),
  const SizedBox(height: 60),
  CvSection(),
  const SizedBox(height: 30),
  const PokedexAd(),
  const SizedBox(height: 60),
  StockMarketAd(),
  const SizedBox(height: 30),
  TestimonialSection(),
  const SizedBox(height: 30),
  ContactSection(),
  const SizedBox(height: 30),
  const Footer()
];
