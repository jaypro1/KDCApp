import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kdc_app/widgets/PincodeTextField.dart';
import 'package:kdc_app/models/KDCUser.class.dart';

class OTPPage extends StatelessWidget {
  OTPPage({Key? key, required this.verificationID}) : super(key: key);

  final String verificationID;
  FirebaseAuth auth = FirebaseAuth.instance;

  _verifyCode(String pin) async {
    print("Verify Code with Pin: $pin");
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: pin);
    UserCredential authVal = await auth.signInWithCredential(credential);

    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    if (authVal.user!.uid.trim() != "") {
      print("Auth Uid: " + authVal.user!.uid);
      DocumentSnapshot<Object?> userDoc =
          await users.doc(authVal.user!.uid).get();
      if (userDoc.exists) {
        print("Has a document in Users");
      } else {
        // Create Document.
        KDCUser newUser = KDCUser("Jay C", "male", "");
        // String data = jsonEncode(newUser);
        try {
          DocumentReference doc = users.doc(authVal.user!.uid);
          doc
              .set(newUser.getDataMap())
              .then((value) => print("User with CustomID added"))
              .catchError((error) => print("Failed to add user: $error"));
        } catch (e) {
          print("Error catch $e");
        }
      }
    }
    print(authVal);
  }

  @override
  Widget build(BuildContext context) {
    return PincodeTextField(
      length: 6,
      onSubmit: _verifyCode,
    );
  }
}
