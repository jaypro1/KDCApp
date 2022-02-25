import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kdc_app/OTPPage.dart';

import 'mixins/ValidatorMixins.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> with ValidatorMixins {
  final formKey = GlobalKey<FormState>(debugLabel: "PhoneLogin");
  String? _phoneNumber;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in! $user');
        DocumentSnapshot<Map<String, dynamic>> userProfile =
            await db.collection("Users").doc(user.uid).get();
        if (!userProfile.exists) {
          //Profile not created yet.
          print("Profile Does not exist");
        }
        switch (userProfile.data()!['role']) {
          case 'Admin':
            print("Admin");
            break;
          case 'User':
            print("User");
            break;
          default:
            print("Default");
        }
      }
    });
  }

  _login() async {
    final bool? formValid = formKey.currentState?.validate();
    formKey.currentState?.save();

    bool authUser = false;
    if (Platform.isAndroid || Platform.isIOS) {
      print("Native App");
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+1 ' + _phoneNumber!.trim().replaceAll("-", ""),
        verificationCompleted: (PhoneAuthCredential credential) {
          print("verification completed");
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
            //todo Show snack bar.
          }
          print("Exception [" + e.message! + "]");
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OTPPage(verificationID: verificationId)));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("timeout" + verificationId);
          //TODO add resend textfield.
        },
        timeout: const Duration(seconds: 60),
      );
    }
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
                getPhoneField(),
                getSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
