import 'package:app_restaurante/src/models/platoModel.dart';
import 'package:app_restaurante/src/preferencias_usuario/preferencias.dart';

import 'package:intl/intl.dart';
import 'package:app_restaurante/src/providers/platosProdiver.dart';
import 'package:flutter/material.dart';

class SearchPlato extends StatefulWidget {
  SearchPlato({Key key}) : super(key: key);

  @override
  SearchPlatoState createState() => SearchPlatoState();
}

class SearchPlatoState extends State<SearchPlato> {
  PlatosProvider platoProvider = new PlatosProvider();
  dynamic buscador;
  final _prefs = new PreferenciasUsuario();
  Widget build(BuildContext context) {
    Map parametro = ModalRoute.of(context).settings.arguments;

    buscador = parametro["value"];
    final buscadores = buscador.replaceAll("_", " ");
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
                buscadores,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              _scrollCard(context, parametro['value']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scrollCard(
    BuildContext context,
    String plato,
  ) {
    return FutureBuilder(
      future: platoProvider.searchPlato(plato, _prefs.token),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Center(
                child: Text(
              "Ups este producto no se encuentra!!",
              style: TextStyle(fontSize: 18, color: Colors.redAccent),
            ));
          } else {
            return ListView.builder(
                physics: ScrollPhysics(parent: ScrollPhysics()),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _card(snapshot.data[index]),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                });
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _card(Plato plato) {
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
        onTap: () {
          if (plato.ingredientes == null) {
            plato.ingredientes = "";
          }
          Navigator.pushNamed(context, 'descriptionDish',
              arguments: {'plato': plato});
        });
  }
}
