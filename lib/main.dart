import 'package:app_restaurante/src/page/login.dart';
import 'package:app_restaurante/src/page/loginVerificacion.dart';
import 'package:app_restaurante/src/page/registro.dart';
import 'package:app_restaurante/src/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'MPLUSRounded1c'
        ),
     
     debugShowCheckedModeBanner: false,
     initialRoute: 'splashScreen',
     routes: {
       'splashScreen': (BuildContext context)=>SplashsCreen(),
       'login': (BuildContext context)=>Login(),
       'loginVerificacion':(BuildContext context)=> LoginVerificacion(),
       'registro':(BuildContext context)=>Registro()
     },
    );
  }
}

