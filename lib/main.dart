import 'package:app_restaurante/src/page/ReviewOrder.dart';
import 'package:app_restaurante/src/page/admin.dart';
import 'package:app_restaurante/src/page/carrito.dart';
import 'package:app_restaurante/src/page/chekout.dart';
import 'package:app_restaurante/src/page/configuracion.dart';
import 'package:app_restaurante/src/page/description.dart';
import 'package:app_restaurante/src/page/historialPedidos.dart';
import 'package:app_restaurante/src/page/home.dart';
import 'package:app_restaurante/src/page/login.dart';
import 'package:app_restaurante/src/page/loginVerificacion.dart';
import 'package:app_restaurante/src/page/navigation.dart';
import 'package:app_restaurante/src/page/order.dart';
import 'package:app_restaurante/src/page/registro.dart';
import 'package:app_restaurante/src/page/searchDireccion.dart';
import 'package:app_restaurante/src/page/searchPlato.dart';
import 'package:app_restaurante/src/page/sendingOrden.dart';
import 'package:app_restaurante/src/splashscreen.dart';
import 'src/page/admin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'MPLUSRounded1c'),
      debugShowCheckedModeBanner: false,
      initialRoute: 'admin',
      routes: {
        'splashScreen': (BuildContext context) => SplashsCreen(),
        'login': (BuildContext context) => Login(),
        'loginVerificacion': (BuildContext context) => LoginVerificacion(),
        'registro': (BuildContext context) => Registro(),
        'navigation': (BuildContext context)=>Navegation(),
        'home': (BuildContext context) => Home(),
        'searchPlato': (BuildContext context) => SearchPlato(),
        'searchDireccion': (BuildContext context) => SearchDireccion(),
        'descriptionDish': (BuildContext context) => DescriptionDish(),
        'chekout': (BuildContext context) => Chekout(),
        'carrito':(BuildContext context)=> Carrito(),
        'reviewOrder': (BuildContext context) => ReviewOrder(),
        'order': (BuildContext context) => OrderProduct(),
        'sendingOrder': (BuildContext context) => SendingOrder(),
        'admin': (BuildContext context) => Adminuser(),
        'historialPedidos' :(BuildContext context) => HistorialPedidos(),
        'configuracion':(BuildContext context) => ConfiguracionUser(),
      },
    );
  }
}
