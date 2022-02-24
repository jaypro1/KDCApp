import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kdc_app/mixins/ValidatorMixins.dart';

import 'GameScanner.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidatorMixins {
  final formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    if (auth == null) print("auth is null");
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        //todo Automatically send user to their respective mainpage. Admin -> admin User -> user
        print('User is signed in!');
      }
    });
  }

  _login() {
    final bool? formValid = formKey.currentState?.validate();
    formKey.currentState?.save();
    if (kDebugMode) {
      print("TODO Logged In");

      // Good practice: https://github.com/anbturki/flutter_login_screen/blob/master/lib/src/screens/login_screen.dart
      print("user; " + (_email ?? "null"));
      print("pass; " + (_password ?? "null"));
    }
    if (formValid ?? false && false) {
      //Todo make Firebase call to verify details.
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => GameScanner()));
      // context, MaterialPageRoute(builder: (context) => BarCodeExample()));
    }
  }

  Widget getEmailField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Email",
          ),
          validator: validateEmail,
          onSaved: (String? val) {
            _email = val;
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
            getEmailField(),
            getPasswordField(),
            getSubmitButton(),
          ],
        ),
      ),
    )));
  }
}
