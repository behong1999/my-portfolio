import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_portfolio/utils/constants.dart';

class CustomWidgets {
  CustomWidgets._();

  static showCustomSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 8),
        padding: const EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          width: double.infinity,
          child: Row(
            children: [
              const SizedBox(width: 20),
              const CircleAvatar(
                  foregroundColor: Colors.green,
                  radius: 25,
                  child: Icon(
                    Icons.check,
                  )),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Success",
                    style: GoogleFonts.oswald(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        backgroundColor: mColor,
      ),
    );
  }
}
