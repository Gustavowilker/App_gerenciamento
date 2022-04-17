import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/provider/users.dart';
import 'package:flutter_application_1/sing_up/sign_up_service.dart';
import 'package:flutter_application_1/values/preferences_key.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class cadastre extends StatefulWidget {
  @override
  State<cadastre> createState() => _cadastreState();
}

class _cadastreState extends State<cadastre> {
  TextEditingController _nameInputController = TextEditingController();
  TextEditingController _emailInputController = TextEditingController();
  TextEditingController _cpfInputController = TextEditingController();
  TextEditingController _idInputController = TextEditingController();
  TextEditingController _funcaoInputController = TextEditingController();
  TextEditingController _passwordInputController = TextEditingController();
  TextEditingController _avatarInputController = TextEditingController();
  TextEditingController _confirmInputController = TextEditingController();

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  Uri url = Uri.https(
      'app-gerenciamento-32e98-default-rtdb.firebaseio.com', '/words.json');

  void _loadFormData(User user) {
    _formData['matricula'] = user.id.toString();
    _formData['name'] = user.name.toString();
    _formData['cpf'] = user.cpf.toString();
    _formData['email'] = user.email.toString();
    _formData['password'] = user.password.toString();
    _formData['funcao'] = user.funcao.toString();
    _formData['avatarUrl'] = user.avatarUrl.toString();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ModalRoute.of(context)!.settings.arguments as User?;

    if (user != null) {
      _loadFormData(user);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  _doSignUp();                  
                },
                icon: Icon(Icons.save))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Form(
                  key: _form,
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(8)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _nameInputController,
                          decoration: const InputDecoration(
                              labelText: 'Nome', border: OutlineInputBorder()),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Nome inválido';
                            } else if (value.trim().length < 3) {
                              return 'Nome muito pequeno. Mínimo 3 letras';
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              _formData['name'] = _nameInputController.text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _cpfInputController,
                          decoration: const InputDecoration(
                              labelText: 'CPF', border: OutlineInputBorder()),
                          onSaved: (value) =>
                              _formData['cpf'] = _cpfInputController.text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _idInputController,
                          decoration: const InputDecoration(
                              labelText: 'Nº de Matrícula',
                              border: OutlineInputBorder()),
                          onSaved: (value) =>
                              _formData['matricula'] = _idInputController.text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _emailInputController,
                          decoration: const InputDecoration(
                              labelText: 'E-mail',
                              border: OutlineInputBorder()),
                          onSaved: (value) =>
                              _formData['email'] = _emailInputController.text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Senha',
                            border: OutlineInputBorder(),
                          ),
                          controller: _passwordInputController,
                          validator: (value) {
                            if (_passwordInputController.text.length < 6) {
                              return 'A senha deve ter pelo menos 6 caracteres';
                            }
                            return null;
                          },
                          obscureText: true,
                          onSaved: (value) => _formData['password'] =
                              _passwordInputController.text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _funcaoInputController,
                          decoration: const InputDecoration(
                              labelText: 'Função',
                              border: OutlineInputBorder()),
                          onSaved: (value) =>
                              _formData['funcao'] = _funcaoInputController.text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _avatarInputController,
                          decoration: const InputDecoration(
                              labelText: 'Url do Avatar',
                              border: OutlineInputBorder()),
                          onSaved: (value) => _formData['avatarUrl'] =
                              _avatarInputController.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _doSignUp() {
    final isValid = _form.currentState?.validate();
    if (isValid == true) {
      SigngUpService()
        .signgUp(_emailInputController.text, _passwordInputController.text);

        _form.currentState?.save();
                    Provider.of<Users>(context, listen: false).put(
                      User(
                          id: _formData['matricula'],
                          name: _formData['name'],
                          email: _formData['email'],
                          cpf: _formData['cpf'],
                          funcao: _formData['funcao'],
                          password: _formData['password'],
                          avatarUrl: _formData['avatarUrl']),
                    );

                      Navigator.of(context).pop();

      User newUser = User(
      name: _nameInputController.text,
      cpf: _cpfInputController.text,
      id: _idInputController.text,
      email: _emailInputController.text,
      password: _passwordInputController.text,
      funcao: _funcaoInputController.text,
      avatarUrl: _avatarInputController.text,
      keepOn: true,
     );
      _saveUser(newUser);
    } 
    
    
    
    
  }

  void _saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      PreferenceKeys.activeUser,
      json.encode(user.toJson()),
    );
  }
}
