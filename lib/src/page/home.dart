import 'package:app_restaurante/src/models/categoryModal.dart';
import 'package:app_restaurante/src/models/directionModal.dart';
import 'package:app_restaurante/src/models/platoModel.dart';
import 'package:app_restaurante/src/providers/categoryProvider.dart';

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
  final categoryProvider = new CateroryProvider();
  TextEditingController clear = new TextEditingController();
  ScrollController scroll = new ScrollController();
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
                _scrollHorizontalCategory(infoProvider.token),
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
<<<<<<< HEAD

=======
>>>>>>> c49c64967fc5cdef7f13528e1adbe95e7f14ab41
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
          onTap: () async {
            await Navigator.pushNamed(context, 'searchDireccion');
            setState(() {});
          },
        )
      ],
    );
  }

  Widget _formSearch() {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: clear,
        decoration: InputDecoration(
            border: InputBorder.none,
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
        validator: (value) {
          if (value.isNotEmpty) {
            return null;
          } else {
            return 'Escriba un plato';
          }
        },
        onFieldSubmitted: (value) {
          _submitPlato(value);
          clear.clear();
        },
      ),
    );
  }

  _submitPlato(String plato) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      final value = plato.replaceAll(" ", "_");

      Navigator.pushNamed(context, 'searchPlato', arguments: {"value": value});
    }
  }

  Widget _descubre() {
    return Container(
      child: Text(
        "Descubrir",
        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _scrollHorizontalCategory(String token) {
    final infoProvider = Provider.of<InfoProvider>(context);
    if (infoProvider.categoria.length == 0) {
      return Container(
        height: 50,
        child: FutureBuilder(
          future: categoryProvider.showCategory(token),
          builder: (BuildContext context,
              AsyncSnapshot<List<CategoryModal>> snapshot) {
            infoProvider.categoria = snapshot.data;
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return _categoryItem(
                      snapshot.data[i].nombre,
                      snapshot.data[i].id,
                    );
                  });
            } else {
              return Text("no hay categoria");
            }
          },
        ),
      );
    } else {
      return Container(
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: infoProvider.categoria.length,
              itemBuilder: (context, i) {
                return _categoryItem(
                  infoProvider.categoria[i].nombre,
                  infoProvider.categoria[i].id,
                );
              }));
    }
  }

  Widget _categoryItem(String text, String id) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
        padding: EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
          color: Color(0xF2EB1515), //new Color.fromRGBO(255, 0, 0, 0.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'category',
            arguments: {'id': id, 'nombre': text});
      },
    );
  }

<<<<<<< HEAD
  Widget _card(String title, String imageUrl, String valor, String id,
      String ingrediente, Map categoria) {
=======
  Widget _card(Plato plato) {
>>>>>>> c49c64967fc5cdef7f13528e1adbe95e7f14ab41
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
                      image:
                          NetworkImage('https://' + plato.imgUri, scale: 1.0),
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
                          plato.nombre,
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
                          "valor " + precio.format(plato.precio),
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
<<<<<<< HEAD
        onTap: () {
          if (ingrediente == null) {
            ingrediente = "";
          }
          Navigator.pushNamed(context, 'descriptionDish', arguments: {
            'id': id,
            'nombre': title,
            'ingredientes': ingrediente,
            'imagen': imageUrl,
            'precio': valor,
            'categoria': categoria
          });
        });
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
                      snapshot.data[index].precio.toString(),
                      snapshot.data[index].id,
                      snapshot.data[index].ingredientes,
                      snapshot.data[index].categoryId),
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
=======
        onTap: () => Navigator.pushNamed(context, 'descriptionDish',
            arguments: {'plato': plato}));
  }

  Widget _scrollCard(String token) {
    final infoProvider = Provider.of<InfoProvider>(context, listen: false);
    print(infoProvider.plato);
    if (infoProvider.plato.length == 0) {
      print("array vacia");
      return FutureBuilder(
        future: platosProvider.getAll(token),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            infoProvider.plato = snapshot.data;
>>>>>>> c49c64967fc5cdef7f13528e1adbe95e7f14ab41

            return ListView.builder(
              physics: ScrollPhysics(parent: ScrollPhysics()),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    _card(snapshot.data[index]),
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
    } else {
      print("array llena");
      return ListView.builder(
        physics: ScrollPhysics(parent: ScrollPhysics()),
        shrinkWrap: true,
        itemCount: infoProvider.plato.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              _card(infoProvider.plato[index]),
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

    }

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
}
