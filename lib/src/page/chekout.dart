import 'package:flutter/material.dart';

class Chekout extends StatefulWidget {
  Chekout({Key key}) : super(key: key);

  @override
  _ChekoutState createState() => _ChekoutState();
}

class _ChekoutState extends State<Chekout> {
  @override
  Widget build(BuildContext context) {
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
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _orden(context),
              SizedBox(
                height: 40,
              ),
              _resumen('68.000', '7.800', '75.800'),
            ],
          ),
        ),
        bottomNavigationBar: _button(context));
  }
}

Widget _button(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: BottomAppBar(
      elevation: 0,
      color: Colors.white,
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(primary: Color(0xF2EB1515), elevation: 5),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Hacer Pedido',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, 'reviewOrder'),
      ),
    ),
  );
}

Widget _resumen(String subtotal, String envio, String total) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Resumen',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      Container(
        color: Color(0xF2EB1515),
        height: 3,
        width: 100,
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
                      subtotal,
                      style: TextStyle(fontSize: 19, color: Color(0xF2979797)),
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
                      envio,
                      style: TextStyle(fontSize: 19, color: Color(0xF2979797)),
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
                      total,
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
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

Widget _orden(BuildContext context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tu \nOrden',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, 'navigation'),
            child: Row(
              children: [
                Text(
                  'Agregar \nproductos',
                  style: TextStyle(
                      fontSize: 18,
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
      _pedidos('Hamburguesa sencilla', '22.000'),
      _pedidos('Hamburguesa sencilla', '22.000'),
      _pedidos('Hamburguesa sencilla', '22.000')
    ],
  );
}

Widget _pedidos(String nombre, String precio) {
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
                Text(
                  nombre,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Icon(Icons.attach_money),
                Text(precio,
                    style: TextStyle(
                      fontSize: 20,
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
