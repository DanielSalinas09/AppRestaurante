import 'package:app_restaurante/src/page/googleSignUp.dart';
import 'package:app_restaurante/src/preferencias_usuario/preferencias.dart';
import 'package:app_restaurante/src/providers/CarritoProvider.dart';

import 'package:app_restaurante/src/providers/infoProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  await Firebase.initializeApp();
  print(prefs.token);

  runApp(MyAPP());
}

class MyAPP extends StatefulWidget {
  @override
  _MyAPPState createState() => _MyAPPState();
}

class _MyAPPState extends State<MyAPP> {
  final _prefs = new PreferenciasUsuario();
  String navegacion;
  @override
  Widget build(BuildContext context) {
    if (_prefs.token != "") {
      navegacion = "navigation";
    } else {
      navegacion = "login";
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => InfoProvider(),
        ),
        ChangeNotifierProvider(create: (_) => CarritoProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'MPLUSRounded1c'),
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        initialRoute: navegacion,
        routes: {
          'splashScreen': (BuildContext context) => SplashsCreen(),
          'login': (BuildContext context) => Login(),
          'loginWithGoogle': (BuildContext context) => GoogleSignUp(),
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
          'historialPedidos': (BuildContext context) => PedidosPendientes(),
          'configuracion': (BuildContext context) => ConfiguracionUser(),
        },
      ),
    );
  }
}
