import 'package:flutter/material.dart';
import 'package:flutter_application_1/componets/user_tile.dart';
import 'package:flutter_application_1/data/dummy_users.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/provider/users.dart';
import 'package:flutter_application_1/routes/app_routes.dart';
import 'package:provider/provider.dart';

class page_usuario extends StatelessWidget {
  const page_usuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Colaboradores'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CADASTRE);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (context, i) => UserTile(users.byIndex(i)),
      ),
    );
  }
}
