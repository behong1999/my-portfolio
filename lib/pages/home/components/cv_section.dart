import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:web_portfolio/models/design_process.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/screen_helper.dart';

class CvSection extends StatelessWidget {
  final List<DesignProcess> designProcesses = [
    DesignProcess(
      title: 'Cross-platform Development',
      icon: const Icon(
        FlutterIcons.phonelink_mdi,
        color: mColor,
      ),
      subtitle:
          'Capable of utilizing various frameworks to develop apps run on different platforms.',
    ),
    DesignProcess(
      title: 'Security and Optimization',
      icon: const Icon(
        Icons.security,
        color: mColor,
      ),
      subtitle:
          'Create mobile apps secure & safe to use and focus on performance improvement.',
    ),
    DesignProcess(
      title: 'Agile Development',
      icon: const Icon(
        Icons.settings_applications_outlined,
        color: mColor,
      ),
      subtitle:
          'Build more collaborative & transparent work environments for the team and client.',
    ),
    DesignProcess(
      title: 'UI/UX DESIGN',
      icon: const Icon(
        Icons.design_services,
        color: mColor,
      ),
      subtitle: 'Develop aesthetical UI with satisfying user experience.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenHelper(
        mobile: _buildUI(context, getMobileMaxWidth(context)),
        tablet: _buildUI(context, kTabletMaxWidth),
        desktop: _buildUI(context, kDesktopMaxWidth));
  }

  Widget _buildUI(BuildContext context, double width) {
    return ResponsiveWrapper(
      maxWidth: width,
      minWidth: width,
      defaultScale: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "LEARN HARD,\nWORK SMART",
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.w900,
                  height: 1.5,
                  fontSize: 18.0,
                ),
              ),
              GestureDetector(
                onTap: () => downloadFile("/assets/docs/CV- Hong Huynh.pdf"),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    "DOWNLOAD CV",
                    style: GoogleFonts.oswald(
                      color: mColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, BoxConstraints constraints) {
              return ResponsiveGridView.builder(
                gridDelegate: ResponsiveGridDelegate(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  maxCrossAxisExtent: ScreenHelper.isTablet(context) ||
                          ScreenHelper.isMobile(context)
                      ? constraints.maxWidth / 2
                      : constraints.maxWidth / 4,
                  childAspectRatio: ScreenHelper.isDesktop(context)
                      ? 5 / 2.6
                      : MediaQuery.of(context).size.aspectRatio * 5 / 3,
                ),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final designProcess = designProcesses[index];
                  return Column(
                    children: [
                      Row(
                        children: [
                          designProcess.icon,
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              designProcess.title,
                              style: GoogleFonts.oswald(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: Divider(
                          thickness: 5,
                          color: mColor,
                        ),
                      ),
                      Text(
                        designProcess.subtitle,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 15.0,
                          height: 1.5,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: designProcesses.length,
              );
            },
          ),
        ],
      ),
    );
  }
}

downloadFile(url) {
  AnchorElement anchorElement = AnchorElement(href: url);
  anchorElement.download = "Download CV";
  anchorElement.click();
}
