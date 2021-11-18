import 'dart:convert';

import 'package:app_restaurante/src/models/platoModel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PedidoProvider {
  String _url = 'backend-delivery2.azurewebsites.net';

  Future<Map<String, dynamic>> pedido(String token, String idUsuario,
      String idDireccion, List<String> platos) async {
    var now = new DateTime.now();
    var formatter = new DateFormat("dd/MM/yyyy");
    String formatedDate = formatter.format(now);

    final url = Uri.https(_url, '/api/pedido/create');

    var body = json.encode({
      "platos": platos,
      "usuario_id": idUsuario,
      "direccion_id": idDireccion,
      "fecha": formatedDate
    });

    final resp = await http.post(url,
        headers: {'x-access-token': token, 'Content-type': 'application/json'},
        body: body);

    final respDecode = jsonDecode(resp.body);
    print(respDecode);
    return respDecode;
  }

  Future<Map<String, dynamic>> cancelarPedido(
      String token, String idPedido) async {
    final url = Uri.https(_url, '/api/pedido/cancel/$idPedido');

    final resp = await http.put(url, headers: {'x-access-token': token});
    final respDecode = jsonDecode(resp.body);
    print(respDecode);
    return respDecode;
  }

  Future<List<Plato>> showPedido(String token, String id) async {
    final url = Uri.https(_url, '/api/pedido/$id');

    final resp = await http.get(url, headers: {'x-access-token': token});

    final respDecode = json.decode(resp.body);
    print(respDecode);
    if (respDecode["message"] == "error al encontrar el pedido") {
      return [];
    } else {
      final plato = Platos.fromJsonList(respDecode["pedido"]["platos"]);
      return plato.platos;
    }
  }

  Future<Map<String, dynamic>> status(String token, String idPedido) async {
    final url = Uri.https(_url, '/api/pedido/get/status/$idPedido');

    final resp = await http.get(url, headers: {'x-access-token': token});

    final respDecode = json.decode(resp.body);
    print(respDecode);
    return respDecode["pedido"];
  }
}
