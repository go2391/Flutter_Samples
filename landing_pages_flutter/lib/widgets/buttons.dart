import 'package:flutter/material.dart';

import '../app_constants.dart';

class CustomButton extends StatelessWidget {
  static final int active = 0;
  static final int normal = 1;
  final Function onPressed;

  int type = 1;

  String text;

  CustomButton(this.text, {Key key, this.onPressed, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: type != active ? Colors.white : Constants.app_color,
      onPressed: this.onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: Constants.app_color)),
      padding: EdgeInsets.all(10),
      elevation: 2.0,
      child: Text(
        '$text',
        style: TextStyle(
            fontSize: 15,
            color: type == active ? Colors.white : Constants.app_color),
      ),
    );
  }
}

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(gradient: gradient, boxShadow: [
        BoxShadow(
          color: Colors.grey[500],
          offset: Offset(0.0, 1.5),
          blurRadius: 1.5,
        ),
      ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
