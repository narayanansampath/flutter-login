import 'package:flutter/material.dart';

import './routes.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final color = const Color(0xffF2CE5E);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: color,
          accentColor: color
      ),
      routes: routes,
      //home: Scaffold(
       // body: LoginScreen(),
      //),
    );
  }
}
