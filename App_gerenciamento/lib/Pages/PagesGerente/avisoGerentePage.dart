import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class avisoGerentePage extends StatefulWidget {
  const avisoGerentePage({Key? key}) : super(key: key);

  @override
  State<avisoGerentePage> createState() => _avisoGerentePageState();
}

class _avisoGerentePageState extends State<avisoGerentePage> {
  List<String> listStrings = <String>[];
  Uri url = Uri.https(
      'app-gerenciamento-32e98-default-rtdb.firebaseio.com', '/words.json');
  TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avisos'),
      ),
      body: Center(
        child: (_isLoading)
            ? CircularProgressIndicator()
            : RefreshIndicator(
                onRefresh: (() => _getInformationFromBack()),
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _controller,
                      decoration:
                          InputDecoration(labelText: 'Insira um Aviso aqui:'),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () => addStringToBack(),
                      child: Text('Enviar Aviso'),
                    ),
                    for (String s in listStrings)
                      Text(
                        s,
                        textAlign: TextAlign.center,
                      )
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _getInformationFromBack() {
    return http.get(url).then((response) {
      Map<String, dynamic> map = json.decode(response.body);
      listStrings = [];
      map.forEach((key, value) {
        setState(() {
          listStrings.add(map[key]['word']);
        });
      });
    });
  }

  void addStringToBack() {
    setState(() {
      this._isLoading = true;
    });
    http
        .post(
      url,
      body: json.encode(
        {'word': _controller.text},
      ),
    )
        .then((value) {
      _controller.text = '';
      _getInformationFromBack().then((value) {
        setState(() {
          this._isLoading = false;
        });
        _controller.text = '';
        final snackBar = SnackBar(
          content: Text('A palavra foi gravada com sucesso!'),
          action: SnackBarAction(
            label: 'Dispensar',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    });
  }
}
