import 'dart:convert';

import 'package:app_restaurante/src/models/platoModel.dart';
import 'package:http/http.dart' as http;

class PlatosProvider {
  String x_access_token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJudW1lcm8iOjMwMDU1MjUwMjgsImNvZGlnbyI6OTY5NjE1LCJpYXQiOjE2MTg0MzI4NjUsImV4cCI6MTYxODQ2MTY2NX0.U61nUhuBz0yIf0pEiyHLje5OhR_MhMeK88dhXz_wP9E';
  String _url = 'backend-delivery.azurewebsites.net';

  Future<List<Plato>> getAll() async {
    final url = Uri.https(_url, '/api/plato');
    final response =
        await http.get(url, headers: {'x-access-token': x_access_token});
    final decodeData = json.decode(response.body);
    final platos = new Platos.fromJsonList(decodeData['platos']);

    return platos.platos;
  }

  Future<Plato> getOne(String id) async {
    final url = Uri.https(_url, '/api/plato/' + id);
    final response =
        await http.get(url, headers: {'x-access-token': x_access_token});
    final decodeData = json.decode(response.body);
    final plato = new Plato.fromJsonMap(decodeData['plato']);

    return plato;
  }
}
