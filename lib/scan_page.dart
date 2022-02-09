import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Scan_Page extends StatefulWidget {
  const Scan_Page({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Scan_Page> createState() => _ScanPageState();
}

class _ScanPageState extends State<Scan_Page> {
  String barcode = "";
  TextEditingController _barCodeInputController = TextEditingController();
  _setBarcode(text) {
    setState(() {
      barcode = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
          child: Column(
        children: <Widget>[
          Card(
            child: TextField(
              controller: _barCodeInputController,
              keyboardType: TextInputType.text,
              onEditingComplete: _setBarcode(_barCodeInputController.text),
            ),
          ),
          Center(child: Text(barcode)),
        ],
      )
          // child: Text(text),
          ),
    );
  }
}
