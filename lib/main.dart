<<<<<<< HEAD
import 'package:app_restaurante/src/providers/cartProvider.dart';
=======
import 'package:app_restaurante/src/providers/CarritoProvider.dart';
>>>>>>> c49c64967fc5cdef7f13528e1adbe95e7f14ab41
import 'package:app_restaurante/src/providers/infoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_restaurante/src/page/ReviewOrder.dart';
import 'package:app_restaurante/src/page/carrito.dart';
import 'package:app_restaurante/src/page/category.dart';
import 'package:app_restaurante/src/page/chekout.dart';
import 'package:app_restaurante/src/page/configuracion.dart';
import 'package:app_restaurante/src/page/description.dart';
import 'package:app_restaurante/src/page/historialPedidos.dart';
import 'package:app_restaurante/src/page/home.dart';
import 'package:app_restaurante/src/page/login.dart';
import 'package:app_restaurante/src/page/loginVerificacion.dart';
import 'package:app_restaurante/src/page/navigation.dart';
import 'package:app_restaurante/src/page/order.dart';
import 'package:app_restaurante/src/page/pagoOnline.dart';
import 'package:app_restaurante/src/page/registro.dart';
import 'package:app_restaurante/src/page/searchDireccion.dart';
import 'package:app_restaurante/src/page/searchPlato.dart';
import 'package:app_restaurante/src/page/sendingOrden.dart';
import 'package:app_restaurante/src/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => InfoProvider(),
        ),
<<<<<<< HEAD
        ChangeNotifierProvider(create: (_) => CarritoProvider()),
=======
        ChangeNotifierProvider(
          create: (_) => CarritoProvider(),
        )
>>>>>>> c49c64967fc5cdef7f13528e1adbe95e7f14ab41
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'MPLUSRounded1c'),
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'splashScreen': (BuildContext context) => SplashsCreen(),
          'login': (BuildContext context) => Login(),
          'loginVerificacion': (BuildContext context) => LoginVerificacion(),
          'registro': (BuildContext context) => Registro(),
          'navigation': (BuildContext context) => Navegation(),
          'home': (BuildContext context) => Home(),
          'searchPlato': (BuildContext context) => SearchPlato(),
          'searchDireccion': (BuildContext context) => SearchDireccion(),
          'descriptionDish': (BuildContext context) => DescriptionDish(),
          'chekout': (BuildContext context) => Chekout(),
          'carrito': (BuildContext context) => Carrito(),
          'reviewOrder': (BuildContext context) => ReviewOrder(),
          'order': (BuildContext context) => OrderProduct(),
          'sendingOrder': (BuildContext context) => SendingOrder(),
          'pagosOnline': (BuildContext context) => PagosOnline(),
          'category': (BuildContext context) => Category(),
          'historialPedidos': (BuildContext context) => HistorialPedidos(),
          'configuracion': (BuildContext context) => ConfiguracionUser(),
        },
      ),
    );
  }
}
