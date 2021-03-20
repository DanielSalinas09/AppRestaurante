import 'package:app_restaurante/src/page/carrito.dart';
import 'package:app_restaurante/src/page/order.dart';
import 'package:app_restaurante/src/page/usuario.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State {
  final textStyleEnviar = TextStyle(color: Color(0xFF4B4A4A3), fontSize: 20.0);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _enviarDireccion(),
              SizedBox(
                height: 20.0,
              ),
              _formSearch(),
              SizedBox(height: 10.0),
              _descubre(),
              SizedBox(height: 10.0),
              _scrollHorizontalCategory(),
              SizedBox(height: 30.0),
              _scrollCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _enviarDireccion() {
    return Row(
      children: [
        Text(
          "Enviar a",
          style: textStyleEnviar,
        ),
        SizedBox(
          width: 10.0,
        ),
        Icon(
          Icons.arrow_forward,
        ),
        SizedBox(
          width: 10.0,
        ),
        InkWell(
          child: Text(
            "Calle 38B # 1c-75",
            style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          onTap: () => {Navigator.pushNamed(context, 'searchDireccion')},
        )
      ],
    );
  }

  Widget _formSearch() {
    return Form(
      key: formKey,
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "Busca un plato",
            labelStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            prefixIcon: Icon(
              Icons.search,
              color: Color(0x7E838989),
            ),
            focusColor: Color(0xffffffff),
            fillColor: Color(0xF2F2F2F2),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            filled: true),
        onFieldSubmitted: (value) =>
            {Navigator.pushNamed(context, 'searchPlato')},
      ),
    );
  }

  Widget _descubre() {
    return Container(
      child: Text(
        "Descubrir",
        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _scrollHorizontalCategory() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _categoryItem("perros calientes", Color(0xF2EB1515), Colors.white),
          _categoryItem("salchipapa", Color(0xF2F2F2F2), Colors.black),
          _categoryItem("hamburguezas", Color(0xF2F2F2F2), Colors.black),
          _categoryItem("pizzas", Color(0xF2F2F2F2), Colors.black),
          _categoryItem("bebidas", Color(0xF2F2F2F2), Colors.black),
          _categoryItem("asados", Color(0xF2F2F2F2), Colors.black),
        ],
      ),
    );
  }

  Widget _categoryItem(String text, Color colorBackground, Color colorText) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        padding: EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
          color: colorBackground, //new Color.fromRGBO(255, 0, 0, 0.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: colorText, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      onTap: () => {Navigator.pushNamed(context, 'category')},
    );
  }

  Widget _card(String title, ImageProvider image, String valor) {
    return InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 500,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                image: DecorationImage(fit: BoxFit.fill, image: image),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              "Atlantico . colombia",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            Text(
              "valor " + valor,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ],
        ),
        onTap: () => Navigator.pushNamed(context, 'descriptionDish'));
  }

  Widget _scrollCard() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _card("hamburguesa secilla", AssetImage('assets/img/burger.jpg'),
              "5.000"),
          SizedBox(
            height: 15.0,
          ),
          _card("pizza de jamon y queso", AssetImage('assets/img/pizza.jpg'),
              "7.000"),
          SizedBox(
            height: 15.0,
          ),
          _card("hamburguesa secilla", AssetImage('assets/img/burger.jpg'),
              "5.000"),
          SizedBox(
            height: 15.0,
          ),
          _card("pizza de jamon y queso", AssetImage('assets/img/pizza.jpg'),
              "7.000"),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }

  _loadPage(int currentIndex, BuildContext context) {
    switch (currentIndex) {
      case 0:
        return Home();
      case 1:
        return OrderProduct();
      case 2:
        return Usuario();
      default:
        return Home();
    }
  }
}
