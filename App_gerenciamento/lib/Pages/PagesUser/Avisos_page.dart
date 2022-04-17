import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/avisos.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../provider/users.dart';

class Avisos extends StatefulWidget {
  const Avisos({Key? key}) : super(key: key);

  @override
  State<Avisos> createState() => _AvisosState();
}

class _AvisosState extends State<Avisos> {
  List<String> listStrings = <String>[];
  Uri url =
      Uri.https('gerenciapp-d4ff3-default-rtdb.firebaseio.com', '/Avisos.json');
  TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Avisoss aviso = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Avisos'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              Center(
                child: (_isLoading)
                    ? CircularProgressIndicator()
                    : RefreshIndicator(
                        onRefresh: (() => _getInformationFromBack()),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 15),
                              child: ElevatedButton(
                                onPressed: () => _getInformationFromBack(),
                                child: Text('Atualizar'),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              for (String s in listStrings)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey,
                    child: ListTile(
                      textColor: Colors.white,
                      title: Text(
                        'Aviso',
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        s,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
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
