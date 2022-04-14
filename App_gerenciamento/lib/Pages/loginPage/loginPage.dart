// ignore_for_file: camel_case_types, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/loginPage/cadastre.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/sing_up/login_service.dart';
import 'package:flutter_application_1/sing_up/sign_up_service.dart';
import 'package:flutter_application_1/values/preferences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  static _loginPageState instance = _loginPageState();
  TextEditingController _emailInputController = TextEditingController();
  TextEditingController _passwordInputController = TextEditingController();

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: Image.asset('assets/imagens/LOGO-HORIZONTAL-01.png'),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailInputController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _passwordInputController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              color: const Color.fromARGB(255, 84, 163, 228),
                              textColor: Colors.white,
                              onPressed: () {
                                _doLogin();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(7),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'Entrar',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            child: Container(
                              child: const Text(
                                'Cadastre-se',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return cadastre();
                              }));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/imagens/papelParede_login.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.2),
          ),
          _body(),
        ],
      ),
    );
  }

  void _doLogin() async {
    String emailForm = _emailInputController.text;
    String passForm = _passwordInputController.text;

    User savedUser = await _getSaveUser();
    if (emailForm == savedUser.email &&
        passForm == savedUser.password &&
        savedUser.funcao == 'Gerente') {
      LoginService().login(emailForm, passForm);
      Navigator.of(context).pushReplacementNamed('/performance');
    } else if (emailForm == savedUser.email &&
        passForm == savedUser.password &&
        savedUser.funcao == 'Colaborador') {
      LoginService().login(emailForm, passForm);
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      print("FALHA NO LOGIN");
    }
  }

  Future<User> _getSaveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonUser = prefs.getString(PreferenceKeys.activeUser).toString();

    Map<String, dynamic> mapUser = json.decode(jsonUser.toString());
    User user = User.fromJson(mapUser);
    return user;
  }
}
