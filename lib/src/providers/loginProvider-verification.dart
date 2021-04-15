import 'dart:convert';

import 'package:app_restaurante/src/models/loginModals.dart';
import 'package:app_restaurante/src/providers/infoProvider.dart';
import 'package:http/http.dart' as http;

class LoginProvider {
  String _message;

  String get message {
    return _message;
  }

  final infoProvider = new InfoProvider();
  final loginModal = new LoginModal();
  Future<bool> user(int number) async {
    String url = "https://backend-delivery.azurewebsites.net/api/auth/login";

    var response =
        await http.post(Uri.parse(url), body: {"numero": number.toString()});

    final respDecode = jsonDecode(response.body);
    loginModal.code = respDecode["codigo"];

    print("El Codigo es " + loginModal.code.toString());
    //print(respDecode);

    if (loginModal.code == null) {
      _message = respDecode["message"];
      print("El mensaje es :" + _message);
      return false;
    } else {
      return true;
    }
  }
}

class LoginVerificationProvider {
  final loginModal = new LoginModal();
  Future<bool> verification(int code, int number) async {
    String url = "https://backend-delivery.azurewebsites.net/api/auth/verify";

    final resp = await http.post(Uri.parse(url), body: {
      "numero": number,
      "codigo": code,
    });

    Map<String, dynamic> respDecode = jsonDecode(resp.body);
    print(respDecode);
    return true;
  }
}
