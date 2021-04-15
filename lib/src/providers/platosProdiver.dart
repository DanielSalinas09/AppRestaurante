import 'dart:convert';

import 'package:app_restaurante/src/models/platoModel.dart';
import 'package:http/http.dart' as http;

class PlatosProvider {
  String x_access_token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJudW1lcm8iOjMxMDg5OTQ5OTEsImNvZGlnbyI6MzY2MzE5LCJpYXQiOjE2MTg0NDgyOTksImV4cCI6MTYxODQ3NzA5OX0.0DXiIrPwSmeEjj3Nosbv3xNjD1ttU_DVeK6Oh2sffnk';
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
