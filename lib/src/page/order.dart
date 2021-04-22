import 'package:app_restaurante/src/models/platoModel.dart';
import 'package:app_restaurante/src/providers/infoProvider.dart';
import 'package:app_restaurante/src/providers/pedidoProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderProduct extends StatefulWidget {
  OrderProduct({Key key}) : super(key: key);

  @override
  _OrderProductState createState() => _OrderProductState();
}

class _OrderProductState extends State<OrderProduct> {
  final pedidoProvider = new PedidoProvider();
  var precio = NumberFormat("#,###", 'es-CO');
  @override
  Widget build(BuildContext context) {
    final infoProvider = Provider.of<InfoProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xF2979797)),
        title: Text(
          'Orden',
          style: TextStyle(
              fontSize: 27,
              color: Color(0xF2979797),
              fontWeight: FontWeight.bold),
        ),
      ),
      body:
          Padding(padding: EdgeInsets.all(20), child: _showOrder(infoProvider)),
    );
  }

  Widget _showOrder(InfoProvider infoProvider) {
    return FutureBuilder(
        future: pedidoProvider.showPedido(
            infoProvider.token, infoProvider.idPedido),
        builder: (BuildContext context, AsyncSnapshot<List<Plato>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, i) {
                return Column(
                  children: [
                    _orden(snapshot.data[i].nombre, snapshot.data[i].precio)
                  ],
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _orden(String nombre, int valor) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  child: Text(
                    nombre,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  size: 22,
                ),
                Text(
                  precio.format(valor),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Divider()
      ],
    );
  }
}
