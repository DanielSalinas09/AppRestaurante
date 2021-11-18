import 'dart:convert';

import 'package:app_restaurante/src/models/categoryModal.dart';
import 'package:app_restaurante/src/models/platoModel.dart';
import 'package:http/http.dart' as http;

class CateroryProvider {
  String _url = "backend-delivery2.azurewebsites.net";
  Future<List<CategoryModal>> showCategory(String token) async {
    final url = Uri.https(_url, '/api/category/');
    final resp = await http.get(url, headers: {'x-access-token': token});
    final respDecode = json.decode(resp.body);
    final category = new CategoriesModal.fromJsonList(respDecode['category']);
    return category.categorys;
  }

  Future<List<Plato>> showPlato(String token, String categoryId) async {
    final url = Uri.https(_url, '/api/plato/category/$categoryId');
    final resp = await http.get(url, headers: {'x-access-token': token});
    final respDecode = json.decode(resp.body);
    final categoryPlato = Platos.fromJsonList(respDecode['platos']);
    return categoryPlato.platos;
  }
}
