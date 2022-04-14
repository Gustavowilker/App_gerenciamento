import 'dart:convert';

import 'package:http/http.dart' as http;

import '../routes/app_routes.dart';

class LoginService {
  login(String email, String password) async {
    var url = Uri.parse(AppRoutes.login);
    var response = await http.post(url,
        body: json.encode(
          {"email": email, "password": password, "returnSecureToken": true},
        ));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
