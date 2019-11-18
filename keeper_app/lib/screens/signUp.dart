import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


class SignUp extends StatefulWidget {
  String _phoneNumber = "";

  SignUp(this._phoneNumber);

  @override
  State<StatefulWidget> createState() {
    return _SignUp(this._phoneNumber);
  }
}

class _SignUp extends State<SignUp> {
  String phoneNumber = "";

  var _formKey = GlobalKey<FormState>();

  var minPadding = 5.0;

  var nameControler = TextEditingController();

  String name;

  var emailControler = TextEditingController();

  String email;

  bool isChecked;

  _SignUp(this.phoneNumber);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                    key: _formKey,

//          color: Colors.black,
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: minPadding, bottom: minPadding),
                            child: TextFormField(
                              controller: nameControler,
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter name';
                                } else
                                  return "";
                              },
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                    fontSize: 13,
                                  ),
                                  labelStyle: textStyle,
                                  labelText: "Name",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              style: textStyle,
                              onChanged: (String change) {
                                setState(() {
                                  name = change;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: minPadding, bottom: minPadding),
                            child: TextFormField(
                              controller: emailControler,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter email id';
                                } else
                                  return "";
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                    fontSize: 13,
                                  ),
                                  labelStyle: textStyle,
                                  labelText: "Email ID",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              style: textStyle,
                              onChanged: (String change) {
                                setState(() {
                                  email = change;
                                });
                              },
                            ),
                          ),
                          Row(
                            children: <Widget>[
//                              Checkbox(value: isChecked, onChanged: null),
                              Text("I agree to Terms & Conditions")
                            ],
                          ),
                          RaisedButton(
                            color: Colors.purple,
                            onPressed: (){},
                            child: Text("SIGN UP"),
                          )
                        ]))))));
  }
}
