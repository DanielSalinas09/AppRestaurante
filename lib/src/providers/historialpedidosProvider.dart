import 'dart:convert';

import 'package:app_restaurante/src/models/historialPedidos.dart';
import 'package:http/http.dart' as http;

class PedidosProvider {
  String _url = 'backend-delivery2.azurewebsites.net';

  Future<List<Historialenviados>> getAll(String userid, String token) async {
    final url = Uri.https(_url, '/api/pedido/get/user/' + userid);
    final response = await http.get(url, headers: {'x-access-token': token});
    final decodeData = json.decode(response.body);
    final pedidos =
        new Historialdelospedidos.fromJsonList(decodeData['pedidos']);
    return pedidos.historialdepedidos;
  }

  Future<Historialenviados> getOne(String id, String token) async {
    final url = Uri.https(_url, '/api/pedido/' + id);
    final response = await http.get(url, headers: {'x-access-token': token});
    final decodeData = json.decode(response.body);
    final historialdepedidos =
        new Historialenviados.fromJsonMap(decodeData['pedidos']);
    return historialdepedidos;
  }
}
