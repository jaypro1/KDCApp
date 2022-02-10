import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class GameScanner extends StatefulWidget {
  const GameScanner({Key? key}) : super(key: key);

  @override
  _GameScannerState createState() => _GameScannerState();
}

class _GameScannerState extends State<GameScanner> {
  TextEditingController barcodeController = TextEditingController();
  bool _isBarCodeValid = false;

  _updateBarcodeValue(val) {
    print("input value? : " + val);
    setState(() {
      _isBarCodeValid = barcodeController.text.length == 8;
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
      barcodeController.text = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: barcodeController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: "Barcode Value",
            errorText: !_isBarCodeValid ? 'Must be 8 characters long' : null,
          ),
          onChanged: _updateBarcodeValue,
        ),
        ElevatedButton(
            onPressed: () => scanBarcodeNormal(),
            child: const Text('Scan barcode')),
        const Text("Meant to scan game barcode"),
      ],
    )));
  }
}
