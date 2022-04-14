import 'dart:convert';

import 'package:flutter_application_1/routes/app_routes.dart';
import 'package:http/http.dart' as http;

class SigngUpService {
  signgUp(String email, String password) async {
    var url = Uri.parse(AppRoutes.urlSignUp);
    var response = await http.post(url,
        body: json.encode(
          {"email": email, "password": password, "returnSecureToken": true},
        ));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
