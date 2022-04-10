import 'package:flutter/material.dart';

class Tarefas extends StatelessWidget {
  const Tarefas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const numItens = 10;
    const _tamanhoFonte = TextStyle(fontSize: 18);

    Widget _buildLista(int index) {
      return ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.card_travel),
          ),
          title: Text(
            'Tarefa  $index',
            style: _tamanhoFonte,
          ),
          trailing: const Icon(Icons.cancel));
    }

    return ListView.builder(
        itemCount: numItens * 2,
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) return const Divider();
          final index = i ~/ 2 + 1;
          return _buildLista(index);
        });
  }
}