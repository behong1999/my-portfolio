import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:web_portfolio/gen/assets.gen.dart';
import 'package:web_portfolio/models/skill.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/screen_helper.dart';

List<Skill> skills = [
  Skill(
    text: "Flutter",
    image: Assets.flutterLogo.path,
  ),
  Skill(
    text: "Kotlin",
    image: Assets.kotlinLogo.path,
  ),
  Skill(
    text: "React",
    image: Assets.reactLogo.path,
  ),
  Skill(
    text: "SQL",
    image: Assets.sqlLogo.path,
  ),
];

class SkillSection extends StatefulWidget {
  @override
  State<SkillSection> createState() => _SkillSectionState();
}

class _SkillSectionState extends State<SkillSection> {
  @override
  Widget build(BuildContext context) {
    return ScreenHelper(
      desktop: _buildUI(kDesktopMaxWidth),
      tablet: _buildUI(kTabletMaxWidth),
      mobile: _buildUI(getMobileMaxWidth(context)),
    );
  }
}

Widget _buildUI(double width) {
  return ResponsiveWrapper(
    maxWidth: width,
    minWidth: width,
    defaultScale: false,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SKILLS',
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.w900,
            height: 1.5,
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 30),
        LayoutBuilder(
          builder: (context, BoxConstraints constraints) {
            return ResponsiveGridView.builder(
              itemCount: skills.length,
              itemBuilder: (context, index) {
                final skill = skills[index];
                return Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        skill.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      skill.text,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
              shrinkWrap: true,
              gridDelegate: ResponsiveGridDelegate(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio:
                    ScreenHelper.isDesktop(context) ? 5 / 2 : 3 / 2,
                maxCrossAxisExtent: ScreenHelper.isDesktop(context)
                    ? constraints.maxWidth / 4
                    : constraints.maxWidth / 2,
              ),
            );
          },
        )
      ],
    ),
  );
}
