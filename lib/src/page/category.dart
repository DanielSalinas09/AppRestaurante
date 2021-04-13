import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category extends StatefulWidget {
  Category({Key key}) : super(key: key);

  @override
  CategoryState createState() => CategoryState();
}

class CategoryState extends State<Category> {
  getUserData() async {
    final response = await http.get(
      Uri.parse('https://backend-delivery.azurewebsites.net/api/category/'),
      headers: {
        'x-access-token':
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJudW1lcm8iOjMwMTYxNjI5MjYsImNvZGlnbyI6ODk2MDk0LCJpYXQiOjE2MTgxNzc4MDEsImV4cCI6MTYxODIwNjYwMX0.PHFCCTWkWKKduqDpQJMvdv5bfszjaJCuZ1wTS_KSa8o"
      },
    );
    final jsonData = jsonDecode(response.body);
    var users = [];

    var data = jsonData["category"][0]['nombre'].toString();
    print(jsonData["category"]);
    List<String> cat;

    for (var catArray in jsonData["category"]) {
      cat.add(catArray["nombre"]);
    }
    print(cat);

    CategoriaData user = CategoriaData(data);
    users.add(user);

    print(response.body);
    return users;
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categorias",
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
        child: Card(
          child: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text('Loading...'),
                  ),
                );
              } else
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.all(13.0),
                          color: Colors.white,
                          child: Column(
                            children: [
                              _formSearch(),
                              SizedBox(
                                height: 20.0,
                              ),
                              _scrollCard((snapshot.data[i].category)),
                            ],
                          ),
                        ),
                      );
                    });
            },
          ),
        ),
      ),
    );
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

  Widget _scrollCard(String perroCaliente) {
    return Column(
      children: [
        _card(perroCaliente, AssetImage('assets/img/burger.jpg'), "5.000"),
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
    );
  }
}

class CategoriaData {
  final String category;

  CategoriaData(this.category);
}
