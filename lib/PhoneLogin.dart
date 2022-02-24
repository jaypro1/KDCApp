import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'GameScanner.dart';
import 'mixins/ValidatorMixins.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> with ValidatorMixins {
  final formKey = GlobalKey<FormState>(debugLabel: "PhoneLogin");
  String? _phoneNumber;
  String? _code;
  String? _currVerificationId;
  ConfirmationResult? _currConfirmationResult;
  bool showMessageVerificationField = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  Widget getMsgCodeField() {
    if (!showMessageVerificationField) return Container();

    return Column(children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Code from Msg. Eg. 234567",
            ),
            validator: validateCodeMessage,
            onSaved: (String? val) {
              _code = val;
            },
          )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: ElevatedButton(
          child: const Text("Submit Code"),
          onPressed: () => _verifyCode(),
        ),
      )
    ]);
  }

  Widget getPhoneField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Phone number",
          ),
          validator: validatePhoneNumber,
          onSaved: (String? val) {
            _phoneNumber = val;
          },
        ));
  }

  _verifyCode() async {
    final bool? formValid = formKey.currentState?.validate();
    formKey.currentState?.save();
    // UserCredential userCredential =
    //     await _currConfirmationResult!.confirm(_code!);
    // print(userCredential);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _currVerificationId!, smsCode: _code!);
    UserCredential AuthVal = await auth.signInWithCredential(credential);
    print(_code!);
    print(AuthVal);
  }

  _login() async {
    final bool? formValid = formKey.currentState?.validate();
    formKey.currentState?.save();
    if (kDebugMode) {
      print("TODO Logged In");
      print("phoneNumber [" + (_phoneNumber!) + "]");
    }
    bool authUser = false;
    if (Platform.isAndroid || Platform.isIOS) {
      print("Native App");

      // ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber(
      //     '+1 ' + _phoneNumber!.trim().replaceAll("-", ""));
      // setState(() {
      //   showMessageVerificationField = true;
      //   _currConfirmationResult = confirmationResult;
      // });
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+1 ' + _phoneNumber!.trim().replaceAll("-", ""),
        verificationCompleted: (PhoneAuthCredential credential) {
          print("verification completed");
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          print("Exception [" + e.message! + "]");
        },
        codeSent: (String verificationId, int? resendToken) {
          print("vId [" + verificationId + "]");
          print("rTok [" + resendToken.toString() + "]");
          setState(() {
            showMessageVerificationField = true;
            _currVerificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("timeout" + verificationId);
          //TODO add resend textfield.
        },
        timeout: Duration(seconds: 60),
      );
    }
    if ((formValid ?? false) && authUser) {
      //Todo make Firebase call to verify details.
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => GameScanner()));
      // context, MaterialPageRoute(builder: (context) => BarCodeExample()));
    }
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
            getPhoneField(),
            getMsgCodeField(),
            getSubmitButton(),
          ],
        ),
      ),
    )));
    ;
  }
}
