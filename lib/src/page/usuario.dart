import 'package:app_restaurante/src/preferencias_usuario/preferencias.dart';

import 'package:flutter/material.dart';

class Usuario extends StatefulWidget {
  Usuario({Key key}) : super(key: key);

  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  final _prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final _sizedScreen = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color(0xEEEEEEEEEE),
        body: ListView(
          children: [
            Column(
              children: [
                _logo(_prefs.nombre, _prefs.apellido),
                Column(
                  children: [
                    Container(
                      width: _sizedScreen.width * 0.7,
                      child: _historialPedidos(),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        width: _sizedScreen.width * 0.7,
                        child: _configuracion()),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        width: _sizedScreen.width * 0.7,
                        child: _cerrarSesion()),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  _logo(String nombre, String apellido) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0))),
      height: 260,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/img/logo.jpg',
            height: 200,
          )),
          Center(
              child: Text(
            'USUARIO',
            style: TextStyle(fontFamily: 'Chonburi', fontSize: 20),
          )),
          Expanded(
            child: Center(
                child: Text(nombre + " " + apellido,
                    style: TextStyle(fontFamily: 'Chonburi', fontSize: 20))),
          ),
        ],
      ),
    );
  }

  _historialPedidos() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            child: Container(
              padding: EdgeInsets.all(7.0),
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Historial de pedidos',
                      style: TextStyle(fontSize: 18.0, fontFamily: 'Chonburi'),
                    ),
                  ),
                  IconButton(
                    alignment: Alignment.bottomRight,
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            onTap: () => {Navigator.pushNamed(context, 'historialPedidos')},
          ),
        ),
      ],
    );
  }

  _configuracion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            child: Container(
              padding: EdgeInsets.all(7.0),
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Configuracion',
                      style: TextStyle(fontSize: 18.0, fontFamily: 'Chonburi'),
                    ),
                  ),
                  IconButton(
                    alignment: Alignment.bottomRight,
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            onTap: () => {Navigator.pushNamed(context, 'configuracion')},
          ),
        ),
      ],
    );
  }

  _cerrarSesion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            child: Container(
              padding: EdgeInsets.all(7.0),
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Cerrar sesión',
                      style: TextStyle(fontSize: 18.0, fontFamily: 'Chonburi'),
                    ),
                  ),
                  IconButton(
                    alignment: Alignment.bottomRight,
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            onTap: () => {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('login', (route) => false),
              _prefs.token = "",
            },
          ),
        ),
      ],
    );
  }
}
