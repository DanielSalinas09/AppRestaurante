import 'package:app_restaurante/src/providers/CarritoProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Carrito extends StatefulWidget {
  Carrito({Key key}) : super(key: key);

  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  var precio = NumberFormat("#,###", 'es-CO');
  @override
  Widget build(BuildContext context) {
    final carritoProvider =
        Provider.of<CarritoProvider>(context, listen: false);
    if (carritoProvider.numeroItems == 0) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xF2979797)),
          title: Text(
            'Carrito',
            style: TextStyle(
                fontSize: 30,
                color: Color(0xF2979797),
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          child: Center(
            child: Text("Agregue platos al carrito para pedir la cena"),
          ),
          color: Colors.white,
          height: double.infinity,
        ),
      );
    } else {
      return WillPopScope(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(color: Color(0xF2979797)),
              title: Text(
                'Carrito',
                style: TextStyle(
                    fontSize: 30,
                    color: Color(0xF2979797),
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: carritoProvider.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        String key =
                            carritoProvider.items.keys.elementAt(index);
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          key: Key(carritoProvider.items[key].nombre),
                          background: Container(
                            color: Color(0x9DEB1515),
                          ),
                          onDismissed: (direccion) {
                            carritoProvider
                                .removerItem(carritoProvider.items[key].id);
                            setState(() {});
                          },
                          child: _orden(
                              carritoProvider.items[key].nombre,
                              (carritoProvider.items[key].precio *
                                  carritoProvider.items[key].cantidad),
                              carritoProvider.items[key].cantidad),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "total " + precio.format(carritoProvider.total),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 250,
                    ),
                    _button(context, carritoProvider)
                  ],
                ),
              ),
            ),
          ),
          onWillPop: _willPopCallback);
    }
  }

  Future<bool> _willPopCallback() async {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('navigation', (route) => false);
    return true; // return true if the route to be popped
  }

  Widget _button(BuildContext context, CarritoProvider carritoProvider) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Color(0xF2EB1515), elevation: 5),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Ir a pagar',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'chekout');
          },
        ),
      ),
    );
  }

  Widget _orden(String nombre, int valor, int cantidad) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 140,
                  child: Text(
                    nombre + " X" + cantidad.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Text(
              precio.format(valor),
              style: TextStyle(
                fontSize: 20,
              ),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Divider(
          color: Colors.black,
        )
      ],
    );
  }

  Widget _counterProduct() {
    return Container(
      height: 45.0,
      margin: EdgeInsets.only(left: 5.0),
      decoration: BoxDecoration(
          color: Color(0x25979797), borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              child: Icon(
                Icons.remove,
                size: 20,
              ),
              onTap: () {
                print('menos');
              },
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              '1',
              style: TextStyle(fontSize: 23),
            ),
            SizedBox(
              width: 15,
            ),
            InkWell(
              child: Icon(Icons.add, size: 20),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
