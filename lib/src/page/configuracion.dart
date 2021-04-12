import 'package:flutter/material.dart';

class ConfiguracionUser extends StatefulWidget {
  ConfiguracionUser({Key key}) : super(key: key);

  @override
  _ConfiguracionUserState createState() => _ConfiguracionUserState();
}

class _ConfiguracionUserState extends State<ConfiguracionUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Configuracion", style: TextStyle(color: Colors.black54)),
      ),
      body: Column(
        children: [
          _form(),
          _form2(),
          _form3(),
          _button(context),
        ],
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
                'Nombre',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              _input(),
            ],
          )),
    );
  }

  Widget _form2() {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Apellido',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              _input(),
            ],
          )),
    );
  }

  Widget _form3() {
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
              _input2(),
            ],
          )),
    );
  }

  Widget _input() {
    return TextField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(),
    );
  }

  Widget _input2() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(),
    );
  }

  Widget _button(BuildContext context) {
    // ignore: deprecated_member_use
    return RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
        color: Color.fromRGBO(233, 47, 72, 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        child: Text(
          'Aplicar',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: () => {Navigator.pushNamed(context, 'loginVerificacion')});
  }
}
