import 'package:app_restaurante/src/preferencias_usuario/preferencias.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:app_restaurante/src/models/loginModals.dart';

import 'package:app_restaurante/src/providers/loginProvider-verification.dart';
import 'package:app_restaurante/src/utils/utils.dart';

import 'package:flutter/material.dart';

class LoginVerificacion extends StatefulWidget {
  LoginVerificacion({Key key}) : super(key: key);

  @override
  _LoginVerificacionState createState() => _LoginVerificacionState();
}

class _LoginVerificacionState extends State<LoginVerificacion> {
  int verify;
  final formKey = GlobalKey<FormState>();
  final loginModal = new LoginModal();
  final loginVerificationProvider = new LoginVerificationProvider();
  final _prefs = new PreferenciasUsuario();

  @override
  void initState() {
    EasyLoading.dismiss();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6E6E6),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _fondo(),
              SizedBox(height: 10),
              _form(),
              SizedBox(height: 90),
              _button()
            ],
          ),
        ),
      ),
    );
  }

  Widget _fondo() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        color: Colors.white,
      ),
      child: Column(children: [
        _logo(),
      ]),
    );
  }

  Widget _logo() {
    return Container(
      child: Center(
        heightFactor: 1.7,
        child: Image(
          image: AssetImage('assets/img/logo.jpg'),
        ),
      ),
    );
  }

  Widget _form() {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enviamos un codigo a tu numero de celular',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Verificacion movil',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              _input(),
            ],
          )),
    );
  }

  Widget _input() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(),
      onSaved: (value) => verify = int.parse(value),
      validator: (value) {
        if (isNumeric(value) && value.length == 6) {
          return null;
        } else {
          return 'Codigo Incorrecto';
        }
      },
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
          'Verificar Codigo',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: () => {_submit()});
  }

  _submit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print("Codigo digitado" + verify.toString());
      EasyLoading.show(
          status: "Loading",
          maskType: EasyLoadingMaskType.black,
          dismissOnTap: false);
      var info =
          await loginVerificationProvider.verification(verify, _prefs.numero);

      print(info);
      if (info[0]) {
        print("TOKEN PERSISTENTE" + _prefs.token);

        _prefs.nombre = info[2]["nombre"];
        _prefs.apellido = info[2]["apellidos"];
        _prefs.idUsuario = info[2]["_id"];

        Navigator.of(context)
            .pushNamedAndRemoveUntil('navigation', (route) => false);
      } else {
        EasyLoading.dismiss();
        _mostrarAlert("El codigo es Incorrecto");
      }
    }
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
}
