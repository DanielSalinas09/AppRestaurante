import 'dart:convert';

import 'package:app_restaurante/src/models/directionModal.dart';
import 'package:http/http.dart' as http;

class DirectionProvider {
  String _url = "backend-delivery.azurewebsites.net";
  Future<List<dynamic>> createAddres(
      String search, String token, int number) async {
    final url = Uri.https(_url, '/api/direccion/create');
    final resp = await http.post(url,
        headers: {'x-access-token': token},
        body: {"numero": number.toString(), "direccion": search});
    final respDecode = jsonDecode(resp.body);

    print(respDecode);

    return [respDecode["direccion"]["_id"]];
  }

  Future<List<DirectionModal>> showDirection(String token, int number) async {
    final url = Uri.https(_url, "/api/direccion");
    print(number);
    final resp = await http.post(url, headers: {
      'x-access-token': token,
    }, body: {
      "numero": number.toString(),
    });
    final respDecode = json.decode(resp.body);

    final direccion =
        new DirectionModals.fromJsonList(respDecode['direcciones']);
    print(direccion.direcciones);
    return direccion.direcciones;
  }

  Future<bool> deleteDirection(String id, String token) async {
    final url = Uri.https(_url, "/api/direccion/remove/$id");
    print(id);
    final resp = await http.delete(url, headers: {
      'x-access-token': token,
    });
    print(json.decode(resp.body));

    return true;
  }
}
