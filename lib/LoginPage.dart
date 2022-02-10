import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kdc_app/barcodeExample.dart';
import 'package:kdc_app/mixins/ValidatorMixins.dart';

import 'GameScanner.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidatorMixins {
  final formKey = GlobalKey<FormState>();
  String? _username;
  String? _password;

  _login() {
    final bool? v = formKey.currentState?.validate();
    formKey.currentState?.save();
    if (kDebugMode) {
      print("TODO Logged In");

      // Good practice: https://github.com/anbturki/flutter_login_screen/blob/master/lib/src/screens/login_screen.dart
      print("user; " + (_username ?? "null"));
      print("pass; " + (_password ?? "null"));
    }
    if (v ?? false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => GameScanner()));
      // context, MaterialPageRoute(builder: (context) => BarCodeExample()));
    }
  }

  Widget getUsernameField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Username",
          ),
          validator: validateUsername,
          onSaved: (String? val) {
            _username = val;
          },
        ));
  }

  Widget getPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: "Password",
        ),
        obscureText: true,
        validator: validatePassword,
        onSaved: (String? val) {
          _password = val;
        },
      ),
    );
  }

  Widget getSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: ElevatedButton(
        child: const Text("Login"),
        onPressed: () => _login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getUsernameField(),
            getPasswordField(),
            getSubmitButton(),
          ],
        ),
      ),
    )));
  }
}
