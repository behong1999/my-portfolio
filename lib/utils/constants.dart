import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//* ---------- String constants ----------
const sendEmailUrl = 'https://api.emailjs.com/api/v1.0/email/send';
const serviceId = 'service_7k5mc6e';
const templateId = 'template_nzyscla';
const userId = '_qrmi58fwHjsKDMGT';

//* ---------- Colors and ThemeData ----------
const Color mColor = Color.fromRGBO(96, 66, 245, 1);

const Color lBackgroundColor = Color.fromRGBO(251, 244, 251, 0.875);
const Color lDangerColor = Color.fromRGBO(249, 77, 38, 1);
const Color lCaptionColor = Color.fromRGBO(7, 17, 26, 1);

const Color dBackgroundColor = Color.fromRGBO(7, 17, 26, 1);
const Color dDangerColor = Color.fromRGBO(247, 75, 37, 1);
const Color dCaptionColor = Color.fromRGBO(253, 253, 253, 0.941);

ThemeData darkTheme(BuildContext context) {
  final platform = Theme.of(context).platform;
  return Theme.of(context).copyWith(
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.white,
      backgroundColor: dBackgroundColor,
    ),
    platform: platform,
    primaryColor: mColor,
    scaffoldBackgroundColor: dBackgroundColor,
    canvasColor: dBackgroundColor,
    textTheme: Theme.of(context).textTheme.apply(
          fontFamily: GoogleFonts.latoTextTheme().toString(),
          displayColor: dCaptionColor,
          bodyColor: dCaptionColor,
        ),
  );
}

ThemeData lightTheme(BuildContext context) {
  final platform = Theme.of(context).platform;
  return Theme.of(context).copyWith(
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.black,
      backgroundColor: lBackgroundColor,
    ),
    platform: platform,
    primaryColor: mColor,
    scaffoldBackgroundColor: lBackgroundColor,
    canvasColor: lBackgroundColor,
    textTheme: Theme.of(context).textTheme.apply(
          fontFamily: GoogleFonts.latoTextTheme().toString(),
          displayColor: lCaptionColor,
          bodyColor: lCaptionColor,
        ),
  );
}

//*---------- maxWidth constants ----------
const double kDesktopMaxWidth = 1200.0;
const double kTabletMaxWidth = 800.0;

double getMobileMaxWidth(BuildContext context) =>
    MediaQuery.of(context).size.width * .8;
