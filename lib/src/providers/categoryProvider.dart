import 'dart:convert';

import 'package:app_restaurante/src/models/categoryModal.dart';

import 'package:http/http.dart' as http;

class CategoryProvider {
  Future<List<CategoryModal>> category() async {
    String url = "https://backend-delivery.azurewebsites.net/api/category";

    final resp = await http.get(Uri.parse(url), headers: {
      "x-access-token":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJudW1lcm8iOjMxMDg5OTQ5OTEsImNvZGlnbyI6MzY2MzE5LCJpYXQiOjE2MTg0NDgyOTksImV4cCI6MTYxODQ3NzA5OX0.0DXiIrPwSmeEjj3Nosbv3xNjD1ttU_DVeK6Oh2sffnk"
    });

    final respDecode = jsonDecode(resp.body);

    print(respDecode);
  }
}
