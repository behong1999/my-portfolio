import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/link.dart';
import 'package:web_portfolio/gen/assets.gen.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/screen_helper.dart';

class StockMarketAd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenHelper(
      desktop: _buildUI(kDesktopMaxWidth),
      tablet: _buildUI(kTabletMaxWidth),
      mobile: _buildUI(getMobileMaxWidth(context)),
    );
  }

  Widget _buildUI(double width) {
    const url = "https://github.com/behong1999/stock-market";
    return LayoutBuilder(
      builder: (context, constraints) {
        return ResponsiveWrapper(
          maxWidth: width,
          minWidth: width,
          child: Center(
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              direction:
                  constraints.maxWidth > 720 ? Axis.horizontal : Axis.vertical,
              children: [
                Expanded(
                  flex: constraints.maxWidth > 720 ? 1 : 0,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "DEVELOPED IN KOTLIN",
                          style: GoogleFonts.oswald(
                            color: mColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "STOCK MARKET APP",
                                style: GoogleFonts.oswald(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 35.0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.moving_outlined,
                              size: 50,
                              color: Color.fromRGBO(0, 245, 8, 1),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                          "Show detailed information and intraday chart of a particular company.",
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Link(
                          uri: Uri.parse(url),
                          target: LinkTarget.blank,
                          builder: (context, followLink) => MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: SizedBox(
                              width: 150,
                              height: 50,
                              child: TextButton(
                                onPressed: followLink,
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(mColor)),
                                child: const Center(
                                  child: Text(
                                    "EXPLORE MORE",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: constraints.maxWidth > 720 ? 1 : 0,
                  child: Image.asset(
                    Assets.stockMarket.path,
                    fit: BoxFit.contain,
                    height: constraints.maxWidth > 720 ? 620 : 500,
                    width: constraints.maxWidth > 720 ? null : 300,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
