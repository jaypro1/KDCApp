import 'package:flutter/material.dart';
import 'package:kdc_app/FirstRoute.dart';
import 'package:kdc_app/my_home_page.dart';
import 'package:kdc_app/scan_page.dart';

import 'LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KDC App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: LoginPage(),
    );
  }
}
