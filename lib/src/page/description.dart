import 'package:app_restaurante/src/providers/CarritoProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DescriptionDish extends StatefulWidget {
  DescriptionDish({Key key}) : super(key: key);

  @override
  _DescriptionDishState createState() => _DescriptionDishState();
}

class _DescriptionDishState extends State<DescriptionDish> {
  int subTotal = 0;
  var precio = NumberFormat("#,###", 'es-CO');
  int counter = 1;
  void asignarBtn(dynamic param) {
    subTotal = param['plato'].precio;
  }

  @override
  void initState() {
    super.initState();
    var param;
    // future that allows us to access context. function is called inside the future
    // otherwise it would be skipped and args would return null
    Future.delayed(Duration.zero, () {
      setState(() {
        param = ModalRoute.of(context).settings.arguments;
      });

      asignarBtn(param);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    Map parametros = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _tituloProducto(
                  parametros['plato'].nombre,
                  'barranquilla',
                  '30 - 40 min',
                  parametros['plato'].precio,
                  parametros['plato'].categoryId['nombre']),
              SizedBox(height: 10),
              _bodyProducto('https://' + parametros['plato'].imgUri),
              SizedBox(height: 20),
              _ingrediente(parametros['plato'].ingredientes)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Container(
            width: _screenSize.width * 0.3,
            child: _counterProduct(parametros['plato'].precio),
          ),
          Container(
              width: _screenSize.width * 0.7,
              child: _button(subTotal, parametros['plato'], context)),
        ],
      ),
    );
  }

  Widget _ingrediente(String ingredientes) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'INGREDIENTES',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              ingredientes,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Color(0xF2C9C9C9),
              height: 1,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: Row(
              children: [
                Icon(Icons.comment),
                Text(
                  'Observación',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            )),
            SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 7,
              maxLength: 2000,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText:
                    'Ej: sin cebbolla, sin picante, mayonesa aparte, etc.',
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _button(int valor, dynamic plato, BuildContext context) {
    final carritoProvider =
        Provider.of<CarritoProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Color(0xF2EB1515), elevation: 5),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  'Agregar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.attach_money),
                Text(
                  precio.format(valor),
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          onPressed: () {
            carritoProvider.agregarItem(
                plato.id, plato.nombre, plato.precio, counter);
            Navigator.pushNamed(context, 'carrito');
          },
        ),
      ),
    );
  }

  Widget _bodyProducto(String img) {
    return Column(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:
                  DecorationImage(image: NetworkImage(img), fit: BoxFit.fill)),
        )
      ],
    );
  }

  Widget _tituloProducto(String title, String ubicacion, String tiempo,
      int valor, String categoria) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(
                  Icons.check_circle,
                  color: Color(0xF2EB1515),
                  size: 20,
                )
              ],
            ),
          ),
          Text(
            ubicacion,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xF2979797)),
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xF2D6D4D4),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Icon(Icons.schedule),
                      Text(
                        tiempo,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xF2D6D4D4),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Icon(Icons.attach_money),
                      Text(
                        // 'asd',
                        precio.format(valor),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
                color: Color(0xF2D6D4D4),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                categoria,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _counterProduct(int precio) {
    return Container(
      height: 45.0,
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          color: Color(0x25979797), borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            InkWell(
              child: Icon(
                Icons.remove,
                size: 25,
              ),
              onTap: () {
                if (counter == 1) {
                } else {
                  setState(() {
                    counter--;
                    subTotal = precio * counter;
                  });
                }
              },
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              counter.toString(),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: 15,
            ),
            InkWell(
              child: Icon(
                Icons.add,
                size: 25,
              ),
              onTap: () {
                setState(() {
                  counter++;
                  subTotal = precio * counter;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
