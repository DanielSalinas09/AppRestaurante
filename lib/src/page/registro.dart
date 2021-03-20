import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
  Registro({Key key}) : super(key: key);

  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6E6E6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _fondo(context),
            SizedBox(height: 10),
            _form(),
            _button(context)
          ],
        ),
      ),
    );
  }
}

Widget _button(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 0,
    ),
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
        onPressed: () => {Navigator.pushNamed(context, 'loginVerificacion')}),
  );
}

Widget _fondo(BuildContext context) {
  return Container(
    height: 300,
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
                onTap: () => Navigator.pushNamed(context, 'login'),
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
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Telefono',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            _input(),
            Text(
              'Nombre',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            _inputNombre(),
            Text(
              'Apellido',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            _inputNombre(),
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
  return TextField(
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(),
  );
}

Widget _inputNombre() {
  return TextField(
    keyboardType: TextInputType.name,
    decoration: InputDecoration(),
  );
}

Widget _input() {
  return TextField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(),
  );
}
