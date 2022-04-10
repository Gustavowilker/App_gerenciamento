import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/provider/users.dart';
import 'package:provider/provider.dart';

class cadastre extends StatefulWidget {
  @override
  State<cadastre> createState() => _cadastreState();
}

class _cadastreState extends State<cadastre> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    _formData['matricula'] = user.id;
    _formData['name'] = user.name;
    _formData['cpf'] = user.cpf;
    _formData['email'] = user.email;
    _formData['password'] = user.password;
    _formData['funcao'] = user.funcao;
    _formData['avatarUrl'] = user.avatarUrl;
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
                  final isValid = _form.currentState?.validate();
                  if (isValid == true) {
                    _form.currentState?.save();
                    Provider.of<Users>(context, listen: false).put(
                      User(
                          id: _formData['matricula'].toString(),
                          name: _formData['name'].toString(),
                          email: _formData['email'].toString(),
                          cpf: _formData['cpf'].toString(),
                          funcao: _formData['funcao'].toString(),
                          password: _formData['password'].toString(),
                          avatarUrl: _formData['avatarUrl'].toString()),
                    );

                    Navigator.of(context).pop();
                  }
                },
                icon: Icon(Icons.save))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _formData['name'],
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nome inválido';
                    } else if (value.trim().length < 3) {
                      return 'Nome muito pequeno. Mínimo 3 letras';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['name'] = value.toString(),
                ),
                TextFormField(
                  initialValue: _formData['cpf'],
                  decoration: InputDecoration(labelText: 'CPF'),
                  onSaved: (value) => _formData['cpf'] = value.toString(),
                ),
                TextFormField(
                  initialValue: _formData['matricula'],
                  decoration: InputDecoration(labelText: 'Nº de Matrícula'),
                  onSaved: (value) => _formData['matricula'] = value.toString(),
                ),
                TextFormField(
                  initialValue: _formData['email'],
                  decoration: InputDecoration(labelText: 'E-mail'),
                  onSaved: (value) => _formData['email'] = value.toString(),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  onSaved: (value) => _formData['password'] = value.toString(),
                ),
                TextFormField(
                  initialValue: _formData['funcao'],
                  decoration: InputDecoration(labelText: 'Função'),
                  onSaved: (value) => _formData['funcao'] = value.toString(),
                ),
                TextFormField(
                  initialValue: _formData['avatarUrl'],
                  decoration: InputDecoration(labelText: 'Url do Avatar'),
                  onSaved: (value) => _formData['avatarUrl'] = value.toString(),
                ),
              ],
            ),
          ),
        ));
  }
}
