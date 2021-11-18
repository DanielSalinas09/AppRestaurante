import 'dart:convert';

import 'package:app_restaurante/src/models/directionModal.dart';
import 'package:http/http.dart' as http;

class DirectionProvider {
  String _url = "backend-delivery2.azurewebsites.net";
  Future<List<dynamic>> createAddres(
      String search, String token, String number) async {
    final url = Uri.https(_url, '/api/direccion/create');
    final resp = await http.post(url,
        headers: {'x-access-token': token},
        body: {"numero": number, "direccion": search});
    final respDecode = jsonDecode(resp.body);
    return [respDecode["direccion"]["_id"]];
  }

  Future<List<DirectionModal>> showDirection(
      String token, String number) async {
    final url = Uri.https(_url, "/api/direccion");
    final resp = await http.post(url, headers: {
      'x-access-token': token,
    }, body: {
      "numero": number,
    });
    final respDecode = json.decode(resp.body);
    final direccion =
        new DirectionModals.fromJsonList(respDecode['direcciones']);

    return direccion.direcciones;
  }

  Future<bool> deleteDirection(String id, String token) async {
    final url = Uri.https(_url, "/api/direccion/remove/$id");

    final resp = await http.delete(url, headers: {
      'x-access-token': token,
    });

    return true;
  }
}
