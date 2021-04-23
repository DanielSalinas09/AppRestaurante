import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app_restaurante/src/models/platoModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_restaurante/src/models/historialPedidos.dart';
import 'package:app_restaurante/src/providers/historialpedidosProvider.dart';
import 'package:app_restaurante/src/providers/infoProvider.dart';
import 'package:provider/provider.dart';

class PedidosPendientes extends StatefulWidget {
  PedidosPendientes({Key key}) : super(key: key);

  @override
  _PedidosPendientesState createState() => _PedidosPendientesState();
}

class _PedidosPendientesState extends State<PedidosPendientes> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title:
            Text("Historial de pedidos", style: TextStyle(color: Colors.grey)),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Column(
              children: [
                SizedBox(
                  height: 5.0,
                ),
                _builderHistorialpedidos(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _pedido(int numeroPedido, String estado, int valor, List plato,
      String id, dynamic pedido) {
    Color colorBar;
    switch (estado) {
      case "enviado":
        colorBar = Colors.blue;
        break;
      case "por confirmar":
        colorBar = Colors.red;
        break;
      case "preparando":
        colorBar = Colors.yellow;
        break;
      case "cancelado":
        colorBar = Colors.black;
        break;
      default:
    }
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "pedido # " + numeroPedido.toString(),
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Expanded(child: SizedBox()),
              Text(
                valor.toString(),
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _listPedido(plato),
              Container(
                decoration: BoxDecoration(
                    color: colorBar, borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: [
                    SizedBox(
                      width: 10,
                      height: 120,
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "calle 38B # 1c-72",
                style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Estado: " + estado,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox()
            ],
          ),
          Divider(
            color: Color(0xF2C7C7C7),
            height: 27,
            thickness: 1.1,
          ),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _listPedido(List platos) {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: platos.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return _itemList(platos[index]['nombre']);
          },
        ),
      ),
    );
  }

  Widget _itemList(String name) {
    return Text(
      name,
      style: TextStyle(
        color: Colors.grey,
      ),
    );
  }

  Widget _builderHistorialpedidos(BuildContext context) {
    final infoProvider = Provider.of<InfoProvider>(context);
    return FutureBuilder(
      future:
          PedidosProvider().getAll(infoProvider.idUsuario, infoProvider.token),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            physics: ScrollPhysics(parent: ScrollPhysics()),
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            itemBuilder: (BuildContext context, int index) {
              return _condicionalPedidos(
                  snapshot.data[index].numero,
                  snapshot.data[index].estado,
                  snapshot.data[index].valor,
                  snapshot.data[index].platos,
                  snapshot.data[index].id,
                  snapshot.data[index].platos);
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

  _condicionalPedidos(int numeroPedido, String estado, int valor, List plato,
      String id, List tamano) {
    return _pedido(numeroPedido, estado, valor, plato, id, tamano[0]["nombre"]);
  }
}
