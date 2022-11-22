import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:url_launcher/link.dart';
import 'package:web_portfolio/models/contact.dart';
import 'package:web_portfolio/utils/constants.dart';

List<Contact> contacts = [
  // Contact(
  //   icon: Zocial.gmail,
  //   title: 'Gmail',
  //   url: 'honghuynhkhon@gmail.com',
  // ),
  Contact(
    icon: Zocial.github,
    title: 'Github',
    url: 'https://github.com/behong1999',
  ),
  Contact(
    icon: Zocial.linkedin,
    title: 'Linkedin',
    url: 'https://www.linkedin.com/in/hong-khon-huynh/',
  ),
];

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple,
              mColor,
              Colors.blue,
            ]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Design and Developed by Hong Huynh',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...contacts.map(
                (contact) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                  child: Link(
                    target: LinkTarget.blank,
                    uri: Uri.parse(contact.url),
                    builder: (context, followLink) {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: CircleAvatar(
                          backgroundColor: mColor,
                          child: IconButton(
                            color: Colors.white,
                            icon: Icon(contact.icon),
                            onPressed: followLink,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
