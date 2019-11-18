import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Sample APP",
    home: SIForm(),
    theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        brightness: Brightness.light),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIForm();
  }
}

class _SIForm extends State<SIForm> {
  String _currentSelected = "Years";
  String principleAmount = "";
  String rateOfInterest = "";
  String term = "";
  var _currencies = ["Years", "Months", "Days"];
  var _formKey = GlobalKey<FormState>();

  String _totalAmount = "0.0";

  final double minPadding = 5.0;
  TextEditingController principleControler = TextEditingController();
  TextEditingController rateOfInterestControler = TextEditingController();
  TextEditingController termControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle;

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Simple Interest Calculator"),
        ),
        body: Form(
          key: _formKey,

//          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                getImageAsser(),
                Padding(
                  padding: EdgeInsets.only(top: minPadding, bottom: minPadding),
                  child: TextFormField(
                    controller: principleControler,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter principle amount';
                      }
                    },
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: 13,
                        ),

                        labelStyle: textStyle,
                        hintText: "Principal",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    style: textStyle,
                    onChanged: (String change) {
                      setState(() {
                        principleAmount = change;
                      });
                    },
                    /*onSubmitted: (String userInput) {
                      setState(() {
                        principleAmount = userInput;
                      });
                    },*/
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: minPadding, bottom: minPadding),
                  child: TextFormField(
                    controller: rateOfInterestControler,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter rate of interest';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: 13,
                        ),
                        labelStyle: textStyle,
                        hintText: "Rate of interest",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    style: textStyle,
                    onChanged: (String change) {
                      setState(() {
                        rateOfInterest = change;
                      });
                    },
                    /*onSubmitted: (String userInput) {
                      setState(() {
                        rateOfInterest = userInput;
                      });
                    },*/
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: minPadding, bottom: minPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                        controller: termControler,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter term';
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            errorStyle: TextStyle(
                              fontSize: 13,
                            ),
                            labelStyle: textStyle,
                            hintText: "Term",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        style: textStyle,
                        onChanged: (String change) {
                          setState(() {
                            term = change;
                          });
                        },
                        /*onSubmitted: (String userInput) {
                          setState(() {
                            term = userInput;
                          });
                        },*/
                      )),
                      Container(
                        child: null,
                        width: minPadding * 5,
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map((String text) {
                            return DropdownMenuItem<String>(
                              value: text,
                              child: Text(text),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              this._currentSelected = newValue ?? "";
                            });
                          },
                          value: _currentSelected,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: minPadding, bottom: minPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text(
                                "Calculate",
                                textScaleFactor: 1.5,
                              ),
                              onPressed: calculateTotal)),

                        Container(
                          width: 10,
                        )
            ,
                      Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text(
                                "Reset",
                              ),
                              onPressed: reset))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(minPadding),
                  child: Text(
                    _totalAmount,
                    style: textStyle,
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget getImageAsser() {
    AssetImage image = AssetImage('images/money.png');
    Image imageasset = Image(image: image, width: 75.0, height: 75.0);
    return Container(
      child: imageasset,
      margin: EdgeInsets.all(minPadding * 3.0),
    );
  }

  void calculateTotal() {
    final principle =
        num.parse(principleControler.text.isEmpty ? "0" : principleAmount);

    final interest = principle *
        ((num.parse(rateOfInterest.isEmpty ? "0" : rateOfInterest) / 100) *
            num.parse(term.isEmpty ? "0" : term));
    setState(() {
      if (_formKey.currentState.validate())
        _totalAmount =
            "Principle Amount : $principle \nTotal Interest Amount : ${interest} \nTotal Amount : ${principle + interest}";
    });
  }

  void reset() {
    setState(() {
      _totalAmount = "";
      principleControler.text = "";
      rateOfInterestControler.text = "";
      termControler.text = "";
    });
  }
}

class ImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}
