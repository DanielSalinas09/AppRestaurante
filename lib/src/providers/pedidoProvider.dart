import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PedidoProvider {
  String _url = 'backend-delivery.azurewebsites.net';
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
}
