import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/avisos.dart';
import 'package:provider/provider.dart';

class AvisoTiler extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final Avisoss aviso = Provider.of(context);
    return ListTile(
      title: Text('Tarefa'),
      subtitle: Text(aviso.listStrings.toString()),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(onPressed: (){},
             icon: Icon(Icons.menu))
          ],
        ),
      ),
    );
  }
}
