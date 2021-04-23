import 'package:app_restaurante/src/page/login.dart';
import 'package:flutter/material.dart';

class SplashsCreen extends StatefulWidget {
  SplashsCreen({Key key}) : super(key: key);

  @override
  _SplashsCreenState createState() => _SplashsCreenState();
}

class Animaccion extends PageRouteBuilder {
  final Widget child;

  Animaccion(this.child)
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return child;
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return FadeTransition(opacity: animation, child: child);
        });
}

class _SplashsCreenState extends State<SplashsCreen> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 4000),
        () => Navigator.of(context).push(Animaccion(Login())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF2EB1515),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
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
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 350,
                  width: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/img/img-mujer.png'),
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
