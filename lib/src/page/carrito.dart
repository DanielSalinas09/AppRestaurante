import 'package:flutter/material.dart';

class Carrito extends StatefulWidget {
  Carrito({Key key}) : super(key: key);

  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        iconTheme: IconThemeData(color: Color(0xF2979797)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Carrito',
        style: TextStyle(
          color: Color(0xF2979797),
          fontSize: 30,
          fontWeight: FontWeight.bold
          )),
        ),
        body: Column(children: [
          _orden()
        ],),
    );
  }
}

Widget _orden() {
  return Column(children: [

  ],);
}