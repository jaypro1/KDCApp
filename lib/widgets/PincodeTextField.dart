import 'package:flutter/material.dart';

class PincodeTextField extends StatefulWidget {
  const PincodeTextField(
      {Key? key, required this.length, required this.onSubmit})
      : super(key: key);

  final int length;
  final Function(String) onSubmit;
  @override
  _PincodeTextFieldState createState() => _PincodeTextFieldState();
}

class _PincodeTextFieldState extends State<PincodeTextField> {
  // final length = widget.length;
  late List<String> pinList;
  late int length;

  @override
  void initState() {
    super.initState();

    length = widget.length;
    pinList = List<String>.filled(widget.length, "");
  }

  collapsePinList() {
    String pincode = pinList.fold(
        "", (String previousValue, String element) => previousValue + element);
    print("Pincode $pincode");
    return pincode;
  }

  List<Widget> getDigitTextFields({required int length}) {
    List<Widget> textFields = List.empty(growable: true);
    for (int i = 0; i < length; i++) {
      // textFields.add(const Spacer());
      textFields.add(SizedBox(
          height: 50,
          width: 35,
          child: TextField(
            textAlign: TextAlign.center,
            autofocus: i == 0,
            keyboardType: TextInputType.number,
            maxLength: 1,
            onChanged: (value) {
              pinList[i] = value;
              if (value.length == 1) {
                if (i == widget.length - 1) {
                  widget.onSubmit("Index: $i | " + collapsePinList());
                } else {
                  FocusScope.of(context).nextFocus();
                }
              }
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusColor: Colors.blue.shade200,
              counterText: "",
              contentPadding: const EdgeInsets.all(8.0),
              // isDense: true,
            ),
          )));
    }
    // textFields.add(const Spacer());

    return textFields;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 41),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.spaceEvenly,
                children: getDigitTextFields(length: widget.length),
              ),
            )
          ],
        ),
      ),
    );
  }
}
