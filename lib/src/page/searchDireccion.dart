import 'package:app_restaurante/src/models/directionModal.dart';
import 'package:app_restaurante/src/preferencias_usuario/preferencias.dart';
import 'package:app_restaurante/src/providers/directionProvider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchDireccion extends StatefulWidget {
  SearchDireccion({Key key}) : super(key: key);

  @override
  SearchDireccionState createState() => SearchDireccionState();
}

class SearchDireccionState extends State<SearchDireccion> {
  final formKey = GlobalKey<FormState>();
  final directionProvider = new DirectionProvider();
  TextEditingController clear = new TextEditingController();
  final _prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Direccion",
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
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(
            children: [
              _formSearch(),
              SizedBox(
                height: 40.0,
              ),
              _showDirection(_prefs.token, _prefs.numero)
            ],
          ),
        ),
      ),
    );
  }

  Widget _showDirection(String token, String number) {
    print("Numero: " + number.toString());
    return FutureBuilder(
      future: directionProvider.showDirection(token, number),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              return _crearItem(context, snapshot.data[i], token);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _formSearch() {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: clear,
        onFieldSubmitted: (value) {
          _submitSearch(value);
          clear.clear();
        },
        validator: (value) {
          if (value.isNotEmpty) {
            return null;
          } else {
            return 'Escriba su direccion';
          }
        },
        decoration: InputDecoration(
            border: InputBorder.none,
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

  _submitSearch(String value) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      var info = await directionProvider.createAddres(
          value, _prefs.token, _prefs.numero);
      _prefs.idDirection = info[0];
      setState(() {
        _showDirection(_prefs.token, _prefs.numero);
      });
    }
  }

  Widget _crearItem(BuildContext context, DirectionModal direction, token) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      background: Container(
        color: Color(0xDCDB0D0D),
      ),
      onDismissed: (direccion) {
        _prefs.direction = "Escoja su direccion";
        directionProvider.deleteDirection(direction.id, token);
      },
      child: ListTile(
        title: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 26,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              direction.direction,
              style: TextStyle(fontSize: 19.0, color: Color(0xFF3535353)),
            )
          ],
        ),
        onTap: () {
          setState(() {
            _submitDireccion(direction);
          });
        },
      ),
    );
  }

  _submitDireccion(DirectionModal direction) {
    setState(() {
      _prefs.direction = direction.direction;
      _prefs.idDirection = direction.id;
    });

    return Navigator.pop(context);
  }
}
