import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'models/Game.class.dart';

class GameScanner extends StatefulWidget {
  const GameScanner({Key? key}) : super(key: key);

  @override
  _GameScannerState createState() => _GameScannerState();
}

class _GameScannerState extends State<GameScanner> {
  TextEditingController barcodeController = TextEditingController();
  bool _isBarCodeValid = false;
  final firestoreInstance = FirebaseFirestore.instance;
  final firestoreAuth = FirebaseAuth.instance;
  _updateBarcodeValue(val) {
    print("input value? : " + val);
    Game game;

    setState(() {
      _isBarCodeValid = barcodeController.text.length == 8;
      if (_isBarCodeValid) {
        //Make A Cloud call to firebase to get game info.

        firestoreInstance
            .collection("Games")
            .doc(barcodeController.text)
            .get()
            .then((value) {
          // print(value.data());
          var data = value.data();
          if (data == null) {
            throw "Invalid Data";
          }
          game = Game(data['barcode'], data['name']);
          print(game);
        }).onError((error, stackTrace) {
          print("error with" + (error.toString()));
          //Invalid Auth.
        });

        // firestoreInstance.collection("Games").doc("Test101").set({
        //   "barcode": barcodeController.text,
        //   "name": "old Shananigans",
        //   "numberOfPlays": 0,
        //   "tokens_given": 0
        // }).then((value) {
        //   print("added");
        // }).onError((error, stackTrace) {
        //   print("error with" + (error.toString()));
        //   //Invalid Auth.
        // });
      }
    });
    print("Updated barcode value: " + barcodeController.text);
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', false, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (barcodeScanRes != "-1") barcodeController.text = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Scan Game")),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 33, vertical: 41),
                child: TextField(
                  controller: barcodeController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    label: const Center(
                      child: Text("Barcode Value"),
                    ),
                    border: const UnderlineInputBorder(),
                    // labelText: "Barcode Value",
                    // todo Make Error Message centered.
                    errorText:
                        !_isBarCodeValid ? 'Must be 8 characters long' : null,
                  ),
                  onChanged: _updateBarcodeValue,
                )),
            ElevatedButton(
                onPressed: () => scanBarcodeNormal(),
                child: const Text('Scan barcode')),
          ],
        )));
  }
}
