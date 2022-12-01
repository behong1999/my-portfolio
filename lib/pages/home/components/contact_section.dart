import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:web_portfolio/models/send_email.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/custom_widgets.dart';
import 'package:web_portfolio/utils/screen_helper.dart';

class ContactSection extends StatelessWidget {
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
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CONTACT',
              style: GoogleFonts.oswald(
                fontWeight: FontWeight.w900,
                fontSize: 18.0,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.phone, color: mColor),
                SizedBox(width: 5),
                Text('+358 (0) 41 369 5757'),
                SizedBox(width: 30),
                Icon(Icons.email, color: mColor),
                SizedBox(width: 5),
                Expanded(child: Text('honghuynhkhon@gmail.com')),
              ],
            ),
            const SizedBox(height: 15),
            const ContactForm(),
          ],
        );
      },
    ),
  );
}

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => ContactFormState();
}

class ContactFormState extends State<ContactForm> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Gradient textButtonColor = const LinearGradient(colors: [
    Colors.purple,
    mColor,
    Colors.blue,
  ]);

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenHelper.isMobile(context)
          ? MediaQuery.of(context).size.height * 0.35
          : MediaQuery.of(context).size.height * 0.25,
      child: Form(
        key: _formKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Flex(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              direction: ScreenHelper.isMobile(context)
                  ? Axis.vertical
                  : Axis.horizontal,
              children: [
                Expanded(
                  flex: ScreenHelper.isMobile(context) ? 1 : 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 35,
                        child: ContactTextField(
                          controller: _name,
                          hint: 'First and Last Name',
                          validator: (value) =>
                              value!.isEmpty ? 'Empty Input' : null,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 35,
                        child: ContactTextField(
                          controller: _email,
                          hint: 'Email',
                          validator: (value) {
                            RegExp regex = RegExp(r'\w+@\w+\.\w+');
                            if (value!.isEmpty) {
                              return 'Empty Input';
                            }
                            return regex.hasMatch(value)
                                ? null
                                : 'Invalid Input';
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  // height: 15,
                  width: 50,
                ),
                Expanded(
                  flex: ScreenHelper.isMobile(context) ? 2 : 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _message,
                        maxLines: ScreenHelper.isMobile(context) ? 5 : 3,
                        style: const TextStyle(color: Colors.black87),
                        validator: (value) {
                          return null;
                        },
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: dCaptionColor,
                            hintText: 'Please write your message here ...',
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 40.0,
                        child: MouseRegion(
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
                                if (_formKey.currentState!.validate()) {
                                  sendEmail(
                                      email: _email.text,
                                      message: _message.text,
                                      name: _name.text);
                                  _email.clear();
                                  _name.clear();
                                  _message.clear();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      CustomWidgets.showCustomSnackbar(context,
                                          'I will reply as fast as possible'));
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "SEND",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.send,
                                    size: 15,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ContactTextField extends StatelessWidget {
  const ContactTextField({
    required this.controller,
    required this.hint,
    required this.validator,
  });

  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black87),
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: dCaptionColor,
        hintText: hint,
      ),
    );
  }
}
