import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TarefasGerente extends StatefulWidget {
  const TarefasGerente({Key? key}) : super(key: key);

  @override
  State<TarefasGerente> createState() => _TarefasGerenteState();
}

class _TarefasGerenteState extends State<TarefasGerente> {
  @override
  List<String> listStrings = <String>[];
  Uri url = Uri.https(
      'gerenciapp2-default-rtdb.firebaseio.com', '/Terefas.json');
  TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
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
                            TextFormField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                  labelText: 'Insira uma tarefa aqui:',
                                  border: OutlineInputBorder()),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 15),
                              child: ElevatedButton(
                                onPressed: () => addStringToBack(),
                                child: Text('Enviar Tarefa:'),
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
                        'Tarefa',
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        s,
                        textAlign: TextAlign.center,
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(onPressed: () {}, icon: Icon(Icons.menu))
                          ],
                        ),
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
          listStrings.add(map[key]['tarefas']);
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
        {'tarefas': _controller.text},
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
