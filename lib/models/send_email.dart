import 'dart:convert';
import 'dart:developer';

import '../utils/constants.dart';
import 'package:http/http.dart' as http;

Future sendEmail({
  String? name,
  required String email,
  String? message,
}) async {
  final url = Uri.parse(sendEmailUrl);
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'user_subject': message == null
                ? 'Greeting from $email'
                : 'New Message from $name',
            'user_message': message ??
                'I am curious about your portfolio. Let\'s talk more.'
          }
        },
      ));
  log(response.body);
}
