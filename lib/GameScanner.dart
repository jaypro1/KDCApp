import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameScanner extends StatefulWidget {
  const GameScanner({Key? key}) : super(key: key);

  @override
  _GameScannerState createState() => _GameScannerState();
}

class _GameScannerState extends State<GameScanner> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text("Meant to scan game barcode"),
    ));
  }
}
