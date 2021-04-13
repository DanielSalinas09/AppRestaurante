import 'dart:convert';

import 'package:http/http.dart' as http;

class RegisterProvider {
  String _state;

  String get state {
    return _state;
  }

  set states(String valor) {
    _state = valor;
  }

  Future<bool> register(
      int numero, String nombre, String apellido, String email) async {
    String url = "https://backend-delivery.azurewebsites.net/api/auth/registro";
    print(numero.toString() + " - " + nombre + " - " + apellido);
    var response = await http.post(Uri.parse(url), body: {
      "numero": numero.toString(),
      "nombre": nombre,
      "apellidos": apellido,
      "email": email
    });

    final decodeResp = jsonDecode(response.body);

    print(decodeResp);
    _state = decodeResp['message'];
    if (_state == "usuario guardado correctametne") {
      return true;
    } else {
      return false;
    }
  }
}
