import 'package:flutter/cupertino.dart';
import 'package:kdc_app/widgets/PincodeTextField.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PincodeTextField(
      length: 8,
      onSubmit: (String pin) {
        print("onSubmitted $pin");
      },
    );
  }
}
