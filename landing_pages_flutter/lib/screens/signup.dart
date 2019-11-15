import 'package:flutter/material.dart';
import 'package:landing_pages_flutter/app_constants.dart';
import 'package:landing_pages_flutter/widgets/buttons.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUp();
  }
}

class _SignUp extends State<SignUp> {
  var _fromKey = GlobalKey<FormState>();

  var _mobileControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _fromKey,
          child: Column(
            children: <Widget>[
              Text(
                "Please take a moment to veriy your phone number.",
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
              Text(
                "We will send you a One Time Passcode",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                controller: _mobileControler,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Constants.app_color,
                  fontSize: 16

                ),
                validator: (String value){
                if(value.isEmpty)
                {
                  return 'Please enter principle amount';
                }else
                  return "";

              },
                decoration: InputDecoration(
                  labelText: "Mobile Number",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
