import 'dart:convert';

import 'package:app_restaurante/src/models/registroModal.dart';
import 'package:http/http.dart' as http;

class RegisterProvider {
  Future<bool> register(RegistroModal register) async {
    String url = "https://backend-delivery.azurewebsites.net/api/auth/registro";

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: registroModalToJson(register));

    final decodeResp = jsonDecode(response.body);

    print(decodeResp);
    return true;
  }
}
