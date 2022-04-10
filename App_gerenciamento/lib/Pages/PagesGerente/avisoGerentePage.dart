import 'package:flutter/material.dart';

class avisoGerentePage extends StatefulWidget {
  const avisoGerentePage({Key? key}) : super(key: key);

  @override
  State<avisoGerentePage> createState() => _avisoGerentePageState();
}

class _avisoGerentePageState extends State<avisoGerentePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avisos'),
      ),
    );
  }
}
