import 'package:flutter/material.dart';
import 'package:flutter_new/home.dart';
import 'package:flutter_new/login.dart';
import 'package:flutter_new/signup.dart';

void main() => runApp(MyApp());

  final routes = {
    '/login': (BuildContext context) => new Login(),
    '/home': (BuildContext context) => new Home(),
    '/signup': (BuildContext context) => new Signup(),
    '/': (BuildContext context) => new Login(),
  };

  class MyApp extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        title: 'flutter App',
        theme: new ThemeData(primarySwatch: Colors.blue),
        home: Login(),
      );
    }
  }
