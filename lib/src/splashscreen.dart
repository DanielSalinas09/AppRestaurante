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
      body: Container(
        color: Colors.red[900],
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/img/logo.jpg')),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Food for everyone',
                      style: TextStyle(
                        fontSize: 65,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MPLUSRounded1c',
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
                child: Row(
              children: [Container()],
            )),
          ],
        ),
      ),
    );
  }
}
