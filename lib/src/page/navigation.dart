import 'package:app_restaurante/src/page/carrito.dart';
import 'package:app_restaurante/src/page/usuario.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Navegation extends StatefulWidget {
  Navegation({Key key}) : super(key: key);

  @override
  _NavegationState createState() => _NavegationState();
}

class _NavegationState extends State<Navegation> {
  int currentIndex = 0;

  final Home homePage = Home();
  final Carrito carritoPage = Carrito();
  final Usuario usuario = Usuario();

  Widget _showPage = new Home();

  Widget _loadPage(int index) {
    switch (index) {
      case 0:
        return homePage;
        break;
      case 1:
        return carritoPage;
        break;
      case 2:
        return usuario;
        break;
      default:
        return new Container(child: Text('No a seleccionado ninguna pagina'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        backgroundColor: Colors.white,
        color: Color(0xF2EB1515),
        height: 50,
        items: <Widget>[
          Icon(Icons.home, size: 25),
          Icon(Icons.shopping_cart_outlined, size: 25),
          Icon(Icons.person, size: 25),
        ],
        onTap: (index) {
          setState(() {
            _showPage = _loadPage(index);
          });
        },
      ),
      body: _showPage,
    );
  }
}
