import 'package:app_restaurante/src/models/registroModal.dart';
import 'package:app_restaurante/src/providers/registroProvider.dart';
import 'package:app_restaurante/src/utils/utils.dart';
import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
  Registro({Key key}) : super(key: key);

  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  RegistroModal registros = new RegistroModal();
  final formKey = GlobalKey<FormState>();
  final registerProvider = new RegisterProvider();

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
              SizedBox(height: 10),
              _form(),
              _button(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 0,
      ),
      // ignore: deprecated_member_use
      child: RaisedButton(
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
          onPressed: () => _submit()),
    );
  }

  _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      registerProvider.register(registros);
    }
  }

  //Navigator.pushNamed(context, 'loginVerificacion')
  //
  Widget _fondo(BuildContext context) {
    return Container(
      height: 280,
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
                InkWell(
                  child: Text(
                    'Iniciar Sesion',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onTap: () => Navigator.popAndPushNamed(context, 'login'),
                ),
              ],
            )),
            Expanded(
                child: Column(
              children: [
                Text(
                  'Registro',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  color: Color(0xF2EB1515),
                  height: 9,
                  width: 137,
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
        heightFactor: 1.3,
        child: Image(
          image: AssetImage('assets/img/logo.jpg'),
        ),
      ),
    );
  }

  Widget _form() {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Telefono',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              _inputNumber(),
              Text(
                'Nombre',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              _inputNombre(),
              Text(
                'Apellido',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              _inputApellido(),
              Text(
                'Email',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              _inputEmail(),
            ],
          )),
    );
  }

  _inputEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(),
      onSaved: (value) => registros.email = value,
      validator: (value) {
        if (validateEmail(value)) {
          return null;
        } else {
          return 'Escriba un correo electronico';
        }
      },
    );
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  Widget _inputApellido() {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(),
      onSaved: (value) => registros.apellido = value,
      validator: (value) {
        if (value.isNotEmpty) {
          return null;
        } else {
          return 'Escribe tu apellido';
        }
      },
    );
  }

  Widget _inputNombre() {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(),
      onSaved: (value) => registros.nombre = value,
      validator: (value) {
        if (value.isNotEmpty) {
          return null;
        } else {
          return 'Escribe tu nombre';
        }
      },
    );
  }

  Widget _inputNumber() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(),
      onSaved: (value) => registros.numero = int.parse(value),
      validator: (value) {
        if (isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }
}
