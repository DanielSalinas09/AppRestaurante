import 'package:flutter/material.dart';

class SearchPlato extends StatefulWidget {
  SearchPlato({Key key}) : super(key: key);

  @override
  SearchPlatoState createState() => SearchPlatoState();
}

class SearchPlatoState extends State<SearchPlato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Buscar Plato",
          style: TextStyle(color: Color(0xFF7575753)),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF7575753)),

        shadowColor: Colors.white,

        backgroundColor: Colors.white,
        centerTitle: true,
        // color
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "hamburguesa",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              _scrollCard(),
            ],
          ),
        ),
      ),
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
}
