import 'package:app_restaurante/src/preferencias_usuario/preferencias.dart';
import 'package:app_restaurante/src/providers/CarritoProvider.dart';

import 'package:app_restaurante/src/providers/pedidoProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReviewOrder extends StatefulWidget {
  ReviewOrder({Key key}) : super(key: key);

  @override
  _ReviewOrderState createState() => _ReviewOrderState();
}

class _ReviewOrderState extends State<ReviewOrder> {
  int _value = 1;
  var conver = NumberFormat("#,###", 'es-CO');
  final pedidoProvider = new PedidoProvider();
  final _prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final carritoProvider =
        Provider.of<CarritoProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xF2979797)),
        title: Text(
          'Revision de orden',
          style: TextStyle(
              fontSize: 25,
              color: Color(0xF2979797),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title('Pedidos'),
                _body(_prefs.direction, '30 - 40 min', carritoProvider.total,
                    context)
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _button(
        context,
        carritoProvider,
      ),
    );
  }

  Widget _title(String nOrder) {
    return Text(
      nOrder,
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget _button(
    BuildContext context,
    CarritoProvider carritoProvider,
  ) {
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
                'Confirmar pedido',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () {
              switch (_value) {
                case 1:
                  _realizarPedido(carritoProvider);

                  break;
                case 2:
                  Navigator.pushNamed(context, 'pagosOnline');
                  break;
                default:
              }
            }),
      ),
    );
  }

  _realizarPedido(CarritoProvider carritoProvider) async {
    carritoProvider.realizarPedido();
    if (_prefs.idDirection == null) {
      _mostrarAlert();
      print("Entro aqui");
    } else {
      print("Direccion: " + _prefs.idDirection);
      Map info = await pedidoProvider.pedido(_prefs.token, _prefs.idUsuario,
          _prefs.idDirection, carritoProvider.datos);

      if (info["message"] == "pedido guardada correctametne") {
        _prefs.idPedido = info["pedido"]["_id"];
        _prefs.estado = info["pedido"]["estado"];

        Navigator.pushNamed(context, 'sendingOrder');
      } else {
        _mostrarAlert();
        print("Entro aqui 2");
      }
    }
  }

  void _mostrarAlert() {
    showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Informacion incorrecta',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            content: Text(
              "El pedido no ha sido efectuado verifique la direccion",
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                child: Text('Ok', style: TextStyle(fontSize: 20)),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Widget _body(
      String direction, String tiempo, int valor, BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: EdgeInsets.only(top: 10)),
      Text(
        'Direccion',
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
      ),
      InkWell(
        onTap: () async {
          await Navigator.pushNamed(context, 'searchDireccion');
          setState(() {});
        },
        child: Container(
          height: 60,
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
              color: Color(0xCBE6E3E3),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(direction,
                  style: TextStyle(
                    fontSize: 18,
                  )),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        'Tiempo de envio',
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
      ),
      InkWell(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 60,
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          decoration: BoxDecoration(
              color: Color(0xCBE6E3E3),
              borderRadius: BorderRadius.circular(15)),
          child: Text('Entrega ' + tiempo,
              style: TextStyle(
                fontSize: 18,
              )),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        'Metodo de Pago',
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
      ),
      InkWell(
        onTap: () {},
        child: Container(
          height: 60,
          padding: EdgeInsets.only(right: 15, top: 15),
          decoration: BoxDecoration(
              // color: Color(0xCBE6E3E3),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: DropdownButton(
                    value: _value,
                    items: [
                      DropdownMenuItem(
                        child: Text("pago Contra entrega",
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "pago online",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        value: 2,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    }),
              ),
              // Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total ',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Icon(Icons.attach_money),
              Text(
                conver.format(valor),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      )
    ]);
  }
}
