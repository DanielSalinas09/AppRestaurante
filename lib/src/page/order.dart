import 'package:app_restaurante/src/models/platoModel.dart';
import 'package:app_restaurante/src/providers/infoProvider.dart';
import 'package:app_restaurante/src/providers/pedidoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderProduct extends StatefulWidget {
  OrderProduct({Key key}) : super(key: key);

  @override
  _OrderProductState createState() => _OrderProductState();
}

class _OrderProductState extends State<OrderProduct> {
  final pedidoProvider = new PedidoProvider();
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

  Widget _showOrder(InfoProvider infoProvider) {}

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
                Container(
                  width: 180,
                  child: Text(
                    "fecha",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFCACACAf),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  size: 22,
                ),
                Text(
                  valor.toString(),
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
