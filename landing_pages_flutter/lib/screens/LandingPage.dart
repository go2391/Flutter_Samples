import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:landing_pages_flutter/widgets/buttons.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  double _currentPosition = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (position) {
                  setState(() {
                    _currentPosition = position * 1.0;
                  });
                },
                pageSnapping: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    color: Colors.green,
                  ),
                  Container(
                    color: Colors.blue,
                  ),
                  Container(
                    color: Colors.red,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DotsIndicator(
                  dotsCount: 3,
                  position: _currentPosition,
                  decorator: DotsDecorator(
                    color: Colors.grey,
                    activeColor: Colors.redAccent,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  CustomButton("LOG IN", onPressed: () {}),
                  SizedBox(
                    width: 50,
                  ),
                  CustomButton("SIGN UP",
                      onPressed: () {}, type: CustomButton.active)
                ],
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
