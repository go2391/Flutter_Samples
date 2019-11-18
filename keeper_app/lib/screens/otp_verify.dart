import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pin_view/pin_view.dart';

class OtpVerify extends StatefulWidget {
  String _phoneNumber = "";

  OtpVerify(this._phoneNumber);

  @override
  State<StatefulWidget> createState() {
    return _OtpVerify(this._phoneNumber);
  }
}

class _OtpVerify extends State<OtpVerify> {
  String phoneNumber = "";

  _OtpVerify(this.phoneNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text("OTP has been sent to you on your mobile phone"),
              Text("$phoneNumber"),
              Expanded(child: PinViewWithSms()),
              RaisedButton(
                onPressed: null,
                child: Text(
                  "VERIFY",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PinViewWithSms extends StatelessWidget {
  final SmsListener smsListener = SmsListener(
      from: '6505551212', // address that the message will come from
      formatBody: (String body) {
        // incoming message type
        // from: "6505551212"
        // body: "Your verification code is: 123-456"
        // with this function, we format body to only contain
        // the pin itself

        String codeRaw = body.split(": ")[1];
        List<String> code = codeRaw.split("-");
        return code.join(); // 341430
      });

  Widget pinViewWithSms(BuildContext context) {
    return PinView(
        count: 6,
        dashPositions: [3],
        autoFocusFirstField: true,
        enabled: true,
        // this makes fields not focusable
        sms: smsListener,
        // listener we created,
        submit: (String pin) {
          // when the message comes, this function
          // will trigger
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Pin received successfully."),
                    content: Text("Entered pin is: $pin"));
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(15.0),
                child: pinViewWithSms(context))));
  }
}
