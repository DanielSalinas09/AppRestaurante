import 'package:app_restaurante/src/models/directionModal.dart';
import 'package:app_restaurante/src/providers/infoProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:app_restaurante/src/providers/platosProdiver.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State {
  final textStyleEnviar = TextStyle(color: Color(0xFF4B4A4A3), fontSize: 20.0);
  final formKey = GlobalKey<FormState>();
  final platosProvider = new PlatosProvider();
  DirectionModal direction = new DirectionModal();

  @override
  Widget build(BuildContext context) {
    final infoProvider = Provider.of<InfoProvider>(context);

    return SafeArea(
      child: Scaffold(
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
                _scrollCard(infoProvider.token),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _enviarDireccion() {
    final infoProvider = Provider.of<InfoProvider>(this.context, listen: false);
    String direccion = infoProvider.direction;
    print(direccion);
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
            direccion,
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

  Widget _card(String title, String imageUrl, String valor) {
    var precio = NumberFormat("#,###", 'es-CO');
    return InkWell(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                    offset: Offset(1.0, 3.0))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 500,
                    height: 200,
                    child: FadeInImage(
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      image: NetworkImage(imageUrl, scale: 1.0),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "Barranquilla . Atlantico",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        Text(
                          "valor " + precio.format(int.parse(valor)),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        onTap: () => Navigator.pushNamed(context, 'descriptionDish'));
  }

  Widget _scrollCard(String token) {
    return FutureBuilder(
      future: platosProvider.getAll(token),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          // return Text("hola");
          return ListView.builder(
            physics: ScrollPhysics(parent: ScrollPhysics()),
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  _card(
                      snapshot.data[index].nombre,
                      'https://' + snapshot.data[index].imgUri,
                      snapshot.data[index].precio.toString()),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
              // return Text("jpñga");
            },
          );
          // return SingleChildScrollView(
          //   child: Column(

          //    _ card(snapshot.data., AssetImage('assets/img/burger.jpg'),
          //         "5.000"),
          //     SizedBox(
          //       height: 15.0,
          //     ),
          //   ),
          // );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

    // SingleChildScrollView(
    // child: Column(
    //   children: [
    //     _card("hamburguesa secilla", AssetImage('assets/img/burger.jpg'),
    //         "5.000"),
    //     SizedBox(
    //       height: 15.0,
    //     ),
    //     _card("pizza de jamon y queso", AssetImage('assets/img/pizza.jpg'),
    //         "7.000"),
    //     SizedBox(
    //       height: 15.0,
    //     ),
    //     _card("hamburguesa secilla", AssetImage('assets/img/burger.jpg'),
    //         "5.000"),
    //     SizedBox(
    //       height: 15.0,
    //     ),
    //     _card("pizza de jamon y queso", AssetImage('assets/img/pizza.jpg'),
    //         "7.000"),
    //     SizedBox(
    //       height: 15.0,
    //     ),
    //   ],
    // ),
    // );
  }

  // _loadPage(int currentIndex, BuildContext context) {
  //   switch (currentIndex) {
  //     case 0:
  //       return Home();
  //     case 1:
  //       return OrderProduct();
  //     case 2:
  //       return Usuario();
  //     default:
  //       return Home();
  //   }
  // }
}
