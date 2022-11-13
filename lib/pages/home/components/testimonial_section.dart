import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:web_portfolio/gen/assets.gen.dart';
import 'package:web_portfolio/models/testimonial.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/screen_helper.dart';

final List<Testimonial> testimonials = [
  Testimonial(
    text:
        "I noticed that Hong Huynh has a great ability to learn new material fast and with good quality. Also, he was able to communicate very well with the team and was able to point out any suggestions he had about the development process of the mobile application.",
    occupation: "Flutter Developer",
    name: "Mohammed Ramadan",
    photo: 'https://avatars.githubusercontent.com/u/55346331?v=4',
  ),
  // Testimonial(
  //   text:
  //       "I noticed that Hong Huynh has a great ability to learn new material fast and with good quality. Also, he was able to communicate very well with the team and was able to point out any suggestions he had about the development process of the mobile application.",
  //   occupation: "Flutter Developer",
  //   name: "Mohammed Ramadan",
  //   photo: 'https://avatars.githubusercontent.com/u/55346331?v=4',
  // ),
];

class TestimonialSection extends StatelessWidget {
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
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "TESTIMONIALS",
            style: GoogleFonts.oswald(
              fontWeight: FontWeight.w900,
              fontSize: 18.0,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Flex(
                direction: ScreenHelper.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                children: testimonials.map((testimonial) {
                  return Expanded(
                    flex: ScreenHelper.isMobile(context) ? 0 : 1,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TestimonialInfo(
                            name: testimonial.name,
                            occupation: testimonial.occupation,
                            photo: testimonial.photo,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            testimonial.text,
                            softWrap: true,
                            style: const TextStyle(height: 1.8, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    ),
  );
}

class TestimonialInfo extends StatelessWidget {
  final String photo;
  final String name;
  final String occupation;

  const TestimonialInfo({
    super.key,
    required this.photo,
    required this.name,
    required this.occupation,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: photo,
            imageBuilder: (context, imageProvider) => Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
            placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: mColor,
                  ),
                ),
            errorWidget: (context, url, error) => CircleAvatar(
                  radius: 30,
                  backgroundImage: Image.asset(Assets.ramadanPhoto.path).image,
                )),
        const SizedBox(
          width: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: GoogleFonts.oswald(
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              occupation,
            )
          ],
        ),
      ],
    );
  }
}
