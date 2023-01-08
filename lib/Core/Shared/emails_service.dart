import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailService {
  static const String url = 'https://api.emailjs.com/api/v1.0/email/send';

  static const String serviceId = 'service_1j8x9xg';
  static const String templateId = 'template_1j8x9xg';
  static const String userId = 'user_1j8x9xg';

  Future<void> sendEmail(
      {required String name,
      required String email,
      required String subject,
      required String body}) async {
    final Uri uri = Uri.parse(url);
    await http.post(
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
            'name': name,
            'email': email,
            'subject': subject,
            'body': body,
          },
        },
      ),
    );
  }
}
