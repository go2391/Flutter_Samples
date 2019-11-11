import 'package:flutter/material.dart';

class FavoriteCity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoriteCityState();
  }
}

class _FavoriteCityState extends State<FavoriteCity> {
  String cityName = "";
  var _currencies = ["Rupees", "Dollar", "Pounds", "Youns", "Others"];

  String _currentSelected = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample State full Widget"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (String change) {
                setState(() {
                  cityName = change;
                });
              },
              onSubmitted: (String userInput) {
                setState(() {
                  cityName = userInput;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.all(10.5),
              child: Text(
                cityName,
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            DropdownButton(
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
            )
          ],
        ),
      ),
    );
  }
}
