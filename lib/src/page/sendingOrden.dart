import 'package:app_restaurante/src/preferencias_usuario/preferencias.dart';
import 'package:app_restaurante/src/providers/CarritoProvider.dart';

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
  final _prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    if (_prefs.estado == "disponible") {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Pedido",
            style: TextStyle(
                fontSize: 30,
                color: Color(0xF2979797),
                fontWeight: FontWeight.bold),
          ),
          elevation: 2.5,
          iconTheme: IconThemeData(color: Color(0xFF7575753)),

          shadowColor: Colors.white,

          backgroundColor: Colors.white,
          centerTitle: true,
          // color
        ),
        body: Center(
          child: Text("Usted no tiene pedidos pendiente"),
        ),
      );
    } else {
      return WillPopScope(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Pedido",
                style: TextStyle(
                    fontSize: 30,
                    color: Color(0xF2979797),
                    fontWeight: FontWeight.bold),
              ),
              elevation: 25,
              iconTheme: IconThemeData(color: Color(0xFF7575753)),

              shadowColor: Colors.white,

              backgroundColor: Colors.white,
              centerTitle: true,
              // color
            ),
            body: FutureBuilder(
              future: pedidoProvider.status(_prefs.token, _prefs.idPedido),
              builder: (BuildContext context,
                  AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasData) {
                  _prefs.estado = snapshot.data["estado"];
                  print("EL ESTADO ACTUAL ES :" + _prefs.estado);
                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Su pedido esta ${_prefs.estado}',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Llegara en 30 - 40 min',
                            style: TextStyle(
                                fontSize: 19, color: Color(0xFF807E7E)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          buttonPedidoRecibido(),
                          SizedBox(
                            height: 9,
                          ),
                          _card(),
                          SizedBox(
                            height: 10,
                          ),
                          _lisView('10:00 PM')
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          onWillPop: _willPopCallback);
    }
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
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          
            child: Container(
              height: 105,
              width: 200,
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
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
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
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 30),
            child: Text(
              'Con Delivery fast food, recibirá la entrega prioritaria de su pedido antes de las 10:00 pm, ¡o correremos por nuestra cuenta!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 20,
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

  Widget _lisView(String tiempo) {
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
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Garantizado',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF9B9999)),
                  ),
                ],
              ),
            ),
            mostrarBotonCancelar(),
          ],
        ),
        Divider(),
        Text(
          'Direccion',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
        ),
        Text(
          _prefs.direction,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Detalles de la Orden ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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

  Widget mostrarBotonCancelar() {
    if (_prefs.estado == "por confirmar") {
      return ElevatedButton(
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
          _submit();
        },
      );
    } else {
      return SizedBox();
    }
  }

  _submit() async {
    Map<String, dynamic> info =
        await pedidoProvider.cancelarPedido(_prefs.token, _prefs.idPedido);
    if (info["message"] == "el pedido ha sido cancelado") {
      _mostrarAlert("Informacion", "El pedido ha sido cancelado");
      _prefs.estado = 'disponible';
    } else if (info["message"] ==
        "el pedido ya se esta preparando, no se puede cancelar") {
      _mostrarAlert("Informacion",
          "El pedido ya se esta preparando, nose puede cancelar");
    } else {
      print("El pedido se cancelo" + info.toString());
    }
  }

  Widget buttonPedidoRecibido() {
    if (_prefs.estado == "enviado") {
      return ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.all(12)),
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xF2EB1515))),
        child: Text(
          "Pedido Recibido",
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () {
          _prefs.estado = "disponible";
          _prefs.idPedido = "";
          Navigator.pushReplacementNamed(context, "navigation");
        },
      );
    } else {
      return SizedBox();
    }
  }
}
