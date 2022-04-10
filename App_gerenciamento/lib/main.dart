import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/PagesGerente/performance.dart';
import 'package:flutter_application_1/Pages/PagesUser/home_page.dart';
import 'package:flutter_application_1/Pages/loginPage/cadastre.dart';
import 'package:flutter_application_1/provider/users.dart';
import 'package:flutter_application_1/routes/app_routes.dart';
import 'package:provider/provider.dart';

import 'Pages/loginPage/loginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Users(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => loginPage(),
          '/home': (context) => const HomePage(),
          '/performance': (context) => const performancePage(),
          AppRoutes.HOME:(_) => HomePage(),
          AppRoutes.PERFORMANCE:(_) => performancePage(),
          AppRoutes.CADASTRE:(_) => cadastre()
        },
      ),
    );
  }
}
