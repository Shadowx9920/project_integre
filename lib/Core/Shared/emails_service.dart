import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../Database/Models/compte.dart';

class EmailService {
  static const String url = 'https://api.emailjs.com/api/v1.0/email/send';

  static const String serviceId = 'service_bwaniep';
  static const String templateId = 'template_x1tvi3j';
  static const String userId = 'mwiq7Y19VrWl3ZI4K';

  static Future<void> sendEmail(
      {required Compte compte,
      required String subject,
      required String message}) async {
    final Uri uri = Uri.parse(url);
    // ignore: unused_local_variable
    Response response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'to_name': compte.name,
            'to_email': compte.email,
            'subject': subject,
            'message': message,
          },
        },
      ),
    );
  }
}
