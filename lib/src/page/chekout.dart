import 'package:app_restaurante/src/providers/CarritoProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Chekout extends StatefulWidget {
  Chekout({Key key}) : super(key: key);

  @override
  _ChekoutState createState() => _ChekoutState();
}

class _ChekoutState extends State<Chekout> {
  var conver = NumberFormat("#,###", 'es-CO');
  @override
  Widget build(BuildContext context) {
    final carritoProvider =
        Provider.of<CarritoProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          iconTheme: IconThemeData(color: Color(0xF2979797)),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Chekout',
              style: TextStyle(
                  color: Color(0xF2979797),
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titulo(context),
                _orden(context, carritoProvider),
                SizedBox(
                  height: 40,
                ),
                _resumen(carritoProvider),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _button(context));
  }

  Widget _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Color(0xF2EB1515), elevation: 5),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Hacer Pedido',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          onPressed: () => Navigator.pushNamed(context, 'reviewOrder'),
        ),
      ),
    );
  }

  Widget _titulo(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tu \nOrden',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, 'navigation'),
            child: Row(
              children: [
                Text(
                  'Agregar \nproductos',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xF2EB1515)),
                ),
                Icon(
                  Icons.add,
                  color: Color(0xF2EB1515),
                )
              ],
            ),
          ),
        ],
      ),
    ]);
  }

  Widget _orden(BuildContext context, CarritoProvider carritoProvider) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: carritoProvider.items.length,
          itemBuilder: (BuildContext context, i) {
            String key = carritoProvider.items.keys.elementAt(i);
            return _pedidos(
                carritoProvider.items[key].nombre,
                (carritoProvider.items[key].precio *
                    carritoProvider.items[key].cantidad));
          }),
    );
  }

  Widget _pedidos(String nombre, int precio) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              child: Row(
                children: [
                  Icon(
                    Icons.done,
                    size: 27,
                    color: Color(0xF2EB1515),
                  ),
                  Container(
                    width: 150,
                    child: Text(
                      nombre,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Icon(Icons.attach_money),
                  Text(conver.format(precio),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    child: Icon(
                      Icons.more_vert,
                      color: Color(0xF2EB1515),
                    ),
                    onTap: () {},
                  )
                ],
              ),
            )
          ]),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Color(0xF2C7C7C7),
            height: 1,
          )
        ],
      ),
    );
  }

  Widget _resumen(CarritoProvider carritoProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Resumen',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container(
          color: Color(0xF2EB1515),
          height: 2,
          width: 90,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          color: Color(0xF2C7C7C7),
          height: 3,
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Costo del Produto',
                  style: TextStyle(fontSize: 19, color: Color(0xF2979797)),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: Color(0xF2979797),
                      ),
                      Text(
                        conver.format(carritoProvider.total),
                        style:
                            TextStyle(fontSize: 19, color: Color(0xF2979797)),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Costo del envio',
                  style: TextStyle(fontSize: 19, color: Color(0xF2979797)),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(Icons.attach_money, color: Color(0xF2979797)),
                      Text(
                        "Gratis",
                        style:
                            TextStyle(fontSize: 19, color: Color(0xF2979797)),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(Icons.attach_money),
                      Text(
                        conver.format(carritoProvider.total),
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
