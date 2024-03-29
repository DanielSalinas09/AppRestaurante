import 'package:app_restaurante/src/preferencias_usuario/preferencias.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:app_restaurante/src/models/loginModals.dart';

import 'package:app_restaurante/src/providers/loginProvider-verification.dart';
import 'package:app_restaurante/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final loginProvider = new LoginProvider();
  LoginModal loginModal = new LoginModal();
  final _prefs = new PreferenciasUsuario();
  TextEditingController clear = new TextEditingController();
  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
    var androidInitialize = new AndroidInitializationSettings('logo');
    var iOsInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOsInitialize);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings); 
  }

  FlutterLocalNotificationsPlugin localNotification;

  Future _showNotication(String code) async {
    var androidDetails = new AndroidNotificationDetails("id de la notificacion",
        "nombre de la notificacion",
        importance: Importance.max, priority: Priority.high);

    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);

    await localNotification.show(0, "Codigo de verificacion",
        "El codigo de verificacion es $code", generalNotificationDetails);
  }

  // InfoProvider infoProvider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6E6E6),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _fondo(context),
              SizedBox(height: 20),
              _form(context),
              SizedBox(height: 80),
              _button(),
              _google(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button() {
    // ignore: deprecated_member_use
    return RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
        color: Color(0xF2EB1515),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        child: Text(
          'Enviar Codigo',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: () {
          submit();
          clear.clear();
        });
  }

  submit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      EasyLoading.show(
          status: "Loading",
          maskType: EasyLoadingMaskType.black,
          dismissOnTap: false);
      List info = await loginProvider.user(_prefs.numero);

      if (info[0]) {
        _showNotication(info[1].toString());
        print("CODIGO: " + info[1].toString());
        Navigator.pushNamed(context, 'loginVerificacion');
      } else {
        EasyLoading.dismiss();
        _mostrarAlert(loginProvider.message);
      }
    }
    return true;
  }

  void _mostrarAlert(String message) {
    showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Informacion incorrecta',
              style: TextStyle(fontSize: 25),
            ),
            content: Text(
              message,
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                child: Text('Ok', style: TextStyle(fontSize: 20)),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Widget _fondo(BuildContext context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          _logo(),
          SizedBox(
            height: 10,
          ),
          Row(children: [
            Expanded(
                child: Column(
              children: [
                Text(
                  'Iniciar Sesion',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  color: Color(0xF2EB1515),
                  height: 9,
                  width: 137,
                ),
              ],
            )),
            Expanded(
                child: Column(
              children: [
                InkWell(
                  child: Text(
                    'Registro',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onTap: () => Navigator.popAndPushNamed(context, 'registro'),
                ),
              ],
            )),
          ]),
        ],
      ),
    );
  }

  Widget _logo() {
    return Container(
      child: Center(
        heightFactor: 1.8,
        child: Image(
          image: AssetImage('assets/img/logo.jpg'),
        ),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Telefono',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              _input(),
            ],
          )),
    );
  }

  Widget _input() {
    final _prefs = new PreferenciasUsuario();
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: clear,
      decoration: InputDecoration(),
      onSaved: (value) => _prefs.numero = int.parse(value),
      validator: (value) {
        if (utils.isNumeric(value) && value.length == 10) {
          return null;
        } else {
          return 'Ingrese su numero de telefono';
        }
      },
    );
  }

  Widget _google() {
    return Center(
      child: GestureDetector(
        onTap: () async {
          try {
            ProgressDialog pr = new ProgressDialog(context);
            pr.style(
                message: 'Entrando a su cuenta...',
                borderRadius: 10.0,
                backgroundColor: Colors.white,
                progressWidget: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                ),
                elevation: 10.0,
                insetAnimCurve: Curves.easeInOut,
                progress: 0.0,
                maxProgress: 100.0,
                progressTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400),
                messageTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600));
            UserCredential userGoogle = await signInWithGoogle();
            pr.show();
            _prefs.nombre = userGoogle.user.displayName;
            // print(userGoogle.user.email);

            print("resp");

            String resp = await loginProvider.loginGoogle(
                context,
                userGoogle.user.uid,
                userGoogle.user.displayName,
                userGoogle.user.phoneNumber,
                userGoogle.additionalUserInfo.isNewUser);
            pr.hide();
            if (resp.substring(0, 13) == "hubo un error") {
              print(resp);
            } else {
              _prefs.token = resp;
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('navigation', (route) => false);
            }

            print(resp);
          } catch (e) {}
        },
        child: Container(
          margin: new EdgeInsets.symmetric(vertical: 20.0),
          width: 244,
          height: 49,
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.network(
                    "https://img.icons8.com/fluency/48/000000/google-logo.png"),
                color: Colors.white,
              ),
              Text('Sign up with Google',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
