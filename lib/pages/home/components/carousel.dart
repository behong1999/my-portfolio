import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:web_portfolio/gen/assets.gen.dart';
import 'package:web_portfolio/models/send_email.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/custom_widgets.dart';

import 'package:web_portfolio/utils/screen_helper.dart';

import '../../../models/carousel_item.dart';

class Carousel extends StatefulWidget {
  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel>
    with SingleTickerProviderStateMixin {
  final CarouselController _carouselController = CarouselController();

  final TextEditingController _emailTextController = TextEditingController();

  String? _validate;

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  Gradient textButtonColor = const LinearGradient(colors: [
    Colors.purple,
    mColor,
    Colors.blue,
  ]);

  @override
  Widget build(BuildContext context) {
    double carouselContainerHeight = MediaQuery.of(context).size.height *
        (ScreenHelper.isMobile(context) ? 0.55 : 0.85);

    List<CarouselItem> carouselList = [
      CarouselItem(
        text: Padding(
          padding: const EdgeInsets.only(right: 45.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MOBILE DEVELOPER",
                style: GoogleFonts.oswald(
                  color: mColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'HONG HUYNH',
                style: GoogleFonts.oswald(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w900,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                "An adaptable Mobile Developer with a collaborative spirit who loves building apps and learning new technologies.",
                softWrap: true,
                style: TextStyle(
                  fontSize: 15.0,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                child: Column(children: [
                  TextField(
                    controller: _emailTextController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: dCaptionColor,
                        hintText: 'Please Enter Your Email Address',
                        errorText: _validate,
                        border: const OutlineInputBorder()),
                  ),
                  const SizedBox(height: 10),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onHover: (event) {
                      setState(() {
                        textButtonColor = const LinearGradient(colors: [
                          Colors.blue,
                          mColor,
                          Colors.purple,
                        ]);
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        textButtonColor = const LinearGradient(colors: [
                          Colors.purple,
                          mColor,
                          Colors.blue,
                        ]);
                      });
                    },
                    child: AnimatedContainer(
                      width: double.infinity,
                      height: 48.0,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          gradient: textButtonColor),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28.0,
                      ),
                      duration: const Duration(seconds: 1),
                      child: TextButton(
                        onPressed: () {
                          RegExp regex = RegExp(r'\w+@\w+\.\w+');
                          _validate = regex.hasMatch(_emailTextController.text)
                              ? null
                              : _emailTextController.text.isEmpty
                                  ? 'Empty Input'
                                  : 'Invalid Input';
                          if (_validate == null) {
                            sendEmail(email: _emailTextController.text);
                            _emailTextController.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              CustomWidgets.showCustomSnackbar(context,
                                  'I will send you a message as fast as possible'),
                            );
                          }
                        },
                        child: const Text(
                          "Let's Talk",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
        image: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
          child: CachedNetworkImage(
            height: carouselContainerHeight,
            fit: BoxFit.cover,
            imageUrl: 'https://avatars.githubusercontent.com/u/44105063?v=4',
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
                color: mColor,
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              height: carouselContainerHeight,
              Assets.carousel.path,
              fit: BoxFit.cover,
            ),
          ),
        ),
      )
    ];

    return SizedBox(
      // color: Colors.red,
      height: carouselContainerHeight,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                // autoPlay: true,
                viewportFraction: 1,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                height: carouselContainerHeight,
              ),
              items: List.generate(carouselList.length, (index) {
                final item = carouselList[index];
                return Builder(
                  builder: (context) => Container(
                    constraints:
                        BoxConstraints(minHeight: carouselContainerHeight),
                    child: ScreenHelper(
                      desktop: _buildDesktop(context, item),
                      tablet: _buildTablet(context, item),
                      mobile: _buildMobile(context, item),
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildDesktop(BuildContext context, CarouselItem item) {
  return Center(
    child: ResponsiveWrapper(
      maxWidth: kDesktopMaxWidth,
      minWidth: kDesktopMaxWidth,
      defaultScale: false,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: item.text),
          Expanded(child: item.image),
        ],
      ),
    ),
  );
}

Widget _buildTablet(BuildContext context, CarouselItem item) {
  return Center(
    child: ResponsiveWrapper(
      maxWidth: kTabletMaxWidth,
      minWidth: kTabletMaxWidth,
      defaultScale: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: item.text),
          Expanded(child: item.image),
        ],
      ),
    ),
  );
}

Widget _buildMobile(BuildContext context, CarouselItem item) {
  return Center(
    child: Container(
      constraints: BoxConstraints(maxWidth: getMobileMaxWidth(context)),
      width: double.infinity,
      child: item.text,
    ),
  );
}
