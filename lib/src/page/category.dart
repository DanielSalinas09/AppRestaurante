import 'package:app_restaurante/src/providers/categoryProvider.dart';
import 'package:app_restaurante/src/providers/infoProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Category extends StatefulWidget {
  Category({Key key}) : super(key: key);

  @override
  CategoryState createState() => CategoryState();
}

class CategoryState extends State<Category> {
  final formKey = GlobalKey<FormState>();
  final categoryProvider = new CateroryProvider();
  @override
  Widget build(BuildContext context) {
    Map parametro = ModalRoute.of(context).settings.arguments;
    final infoProvider = Provider.of<InfoProvider>(context);
    print("Mapa de categoria :" + parametro['id']);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Categorias",
            style: TextStyle(color: Color(0xFF7575753)),
          ),
          elevation: 2,
          iconTheme: IconThemeData(color: Color(0xFF7575753)),

          shadowColor: Colors.white,

          backgroundColor: Colors.white,
          centerTitle: true,
          // color
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(13.0),
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    parametro['nombre'],
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _scrollCard(infoProvider.token, parametro['id']),
                ],
              )),
        ));
  }

  Widget _formSearch() {
    return Form(
      key: formKey,
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "Buscar un plato",
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
      ),
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

  Widget _scrollCard(String token, String id) {
    return FutureBuilder(
      future: categoryProvider.showPlato(token, id),
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
              },
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
