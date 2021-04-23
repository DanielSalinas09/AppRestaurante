import 'package:flutter/material.dart';

class SplashsCreen extends StatefulWidget {
  SplashsCreen({Key key}) : super(key: key);

  @override
  _SplashsCreenState createState() => _SplashsCreenState();
}

class _SplashsCreenState extends State<SplashsCreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF2EB1515),
      body: Container(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/img/logo.jpg'),
                  )),
            ),
            Text(
              'Delivery Fast Food',
              style: TextStyle(
                fontSize: 65,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'MPLUSRounded1c',
              ),
            ),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/img/img-mujer.jpg'),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
