import 'package:app_restaurante/src/providers/CarritoProvider.dart';
import 'package:app_restaurante/src/providers/infoProvider.dart';
import 'package:app_restaurante/src/providers/pedidoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendingOrder extends StatefulWidget {
  SendingOrder({Key key}) : super(key: key);

  @override
  _SendingOrderState createState() => _SendingOrderState();
}

class _SendingOrderState extends State<SendingOrder> {
  final pedidoProvider = new PedidoProvider();
  @override
  Widget build(BuildContext context) {
    final infoProvider = Provider.of<InfoProvider>(this.context, listen: false);
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Pedido",
              style: TextStyle(
                  fontSize: 30,
                  color: Color(0xF2979797),
                  fontWeight: FontWeight.bold),
            ),
            elevation: 0,
            iconTheme: IconThemeData(color: Color(0xFF7575753)),

            shadowColor: Colors.white,

            backgroundColor: Colors.white,
            centerTitle: true,
            // color
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Se esta preparando tu pedido',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Llegara en 30 - 40 min',
                    style: TextStyle(fontSize: 19, color: Color(0xFF807E7E)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _card(),
                  SizedBox(
                    height: 10,
                  ),
                  _lisView('10:00 PM', infoProvider)
                ],
              ),
            ),
          ),
        ),
        onWillPop: _willPopCallback);
  }

  Future<bool> _willPopCallback() async {
    final carritoProvider =
        Provider.of<CarritoProvider>(this.context, listen: false);
    carritoProvider.vaciarCarrito();
    Navigator.of(context)
        .pushNamedAndRemoveUntil("navigation", (Route<dynamic> route) => false);

    return true; // return true if the route to be popped
  }

  Widget _card() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: Color(0x88B1AEAE)),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Text(
            'Tu orden',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(
                color: Color(0xF2EB1515),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    '30 - 40 min',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Hora de entrega',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Text(
              'Con Take-Out Express, recibirá la entrega prioritaria de su pedido antes de las 10:00 pm, ¡o correremos por nuestra cuenta!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/carroExpress.jpg'))),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _lisView(String tiempo, InfoProvider infoProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hora',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    tiempo,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Garantizado',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF9B9999)),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(12)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xF2EB1515))),
              child: Text(
                "Cancelar Pedido",
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                _submit(infoProvider);
              },
            ),
          ],
        ),
        Divider(),
        Text(
          'Direccion',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
        ),
        Text(
          infoProvider.direction,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Detalles de la Orden ',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, 'order'),
              child: Text(
                'Ver \norden',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xF2EB1515)),
              ),
            )
          ],
        ),
        Divider()
      ],
    );
  }

  _submit(InfoProvider infoProvider) async {
    Map<String, dynamic> info = await pedidoProvider.cancelarPedido(
        infoProvider.token, infoProvider.idPedido);
    if (info["message"] == "el pedido ha sido cancelado") {
      _mostrarAlert("Informacion", "El pedido ha sido cancelado");
    } else if (info["message"] ==
        "el pedido ya se esta preparando, no se puede cancelar") {
      _mostrarAlert("Informacion",
          "El pedido ya se esta preparando, nose puede cancelar");
    } else {
      print("El pedido se cancelo" + info.toString());
    }
  }

  void _mostrarAlert(String title, String message) {
    showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            content: Text(
              message,
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                  child: Text('Ok', style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    final carritoProvider = Provider.of<CarritoProvider>(
                        this.context,
                        listen: false);
                    carritoProvider.vaciarCarrito();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "navigation", (Route<dynamic> route) => false);
                  })
            ],
          );
        });
  }
}
