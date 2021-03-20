import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  Category({Key key}) : super(key: key);

  @override
  CategoryState createState() => CategoryState();
}

class CategoryState extends State<Category> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Perros calientes",
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
        margin: EdgeInsets.all(13.0),
        color: Colors.white,
        child: Column(
          children: [
            _formSearch(),
            SizedBox(
              height: 20.0,
            ),
            _direccion("calle 38B #1c-72"),
            SizedBox(
              height: 20.0,
            ),
            _direccion("calle 38B #1c-72"),
            SizedBox(
              height: 20.0,
            ),
            _direccion("calle 38B #1c-72"),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _formSearch() {
    return Form(
      key: formKey,
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "Agregar una direccion",
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

  Widget _direccion(String direccion) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 26,
        ),
        Text(
          direccion,
          style: TextStyle(fontSize: 17.0, color: Color(0xFF4B4A4A3)),
        )
      ],
    );
  }
}
