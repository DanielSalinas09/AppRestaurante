import 'dart:convert';

import 'package:app_restaurante/src/models/categoryModal.dart';
import 'package:http/http.dart' as http;

class CateroryProvider {
  String _url = "backend-delivery.azurewebsites.net";
  Future<List<CategoryModal>> showCategory(String token) async {
    final url = Uri.https(_url, '/api/category/');

    final resp = await http.get(url, headers: {'x-access-token': token});

    final respDecode = json.decode(resp.body);

    final category = new CategoriesModal.fromJsonList(respDecode['category']);

    return category.categorys;
  }
}
