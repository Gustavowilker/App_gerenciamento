import 'package:flutter/material.dart';

class Avisos extends StatelessWidget {
  const Avisos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        children: List.generate(8, (index) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 49, 109, 110), width: 3.8),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              padding: const EdgeInsets.all(40),
              child: Text(
                'Aviso $index',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          );
        }));
  }
}