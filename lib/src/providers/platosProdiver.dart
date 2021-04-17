import 'dart:convert';

import 'package:app_restaurante/src/models/platoModel.dart';
import 'package:http/http.dart' as http;

class PlatosProvider {
  String _url = 'backend-delivery.azurewebsites.net';

  Future<List<Plato>> getAll(String token) async {
    final url = Uri.https(_url, '/api/plato');
    final response = await http.get(url, headers: {'x-access-token': token});
    final decodeData = json.decode(response.body);
    final platos = new Platos.fromJsonList(decodeData['platos']);

    return platos.platos;
  }

  /*Future<Plato> getOne(String id) async {
    final url = Uri.https(_url, '/api/plato/' + id);
    final response =
        await http.get(url, headers: {'x-access-token': x_access_token});
    final decodeData = json.decode(response.body);
    final plato = new Plato.fromJsonMap(decodeData['plato']);

    return plato;
  }
  */
  Future<List<Plato>> searchPlato(String plate, String token) async {
    final url = Uri.https(_url, '/api/plato/getbyname/$plate');

    final resp = await http.get(url, headers: {
      'x-access-token': token,
    });

    final respDecode = json.decode(resp.body);

    final platosList = Platos.fromJsonList(respDecode['platos']);
    print(respDecode);
    return platosList.platos;
  }
}
