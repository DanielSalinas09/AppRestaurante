import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:app_restaurante/src/models/loginModals.dart';
import 'package:app_restaurante/src/preferencias_usuario/preferencias.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;

class LoginProvider {
  String _message;

  String get message {
    return _message;
  }

  String _url = 'backend-delivery.azurewebsites.net';
  final loginModal = new LoginModal();
  Future<List<dynamic>> user(String number) async {
    String url = "https://backend-delivery.azurewebsites.net/api/auth/login";

    var response = await http.post(Uri.parse(url), body: {"numero": number});

    final respDecode = jsonDecode(response.body);
    loginModal.code = respDecode["codigo"];
    print(respDecode);

    print("El Codigo es " + loginModal.code.toString());

    if (loginModal.code == null) {
      _message = respDecode["message"];
      print("El mensaje es :" + _message);
      return [false];
    } else {
      return [true, respDecode["codigo"]];
    }
  }

  Future<String> loginGoogle(BuildContext context, String uid, String name,
      phone, bool newUser) async {
    // pr = new ProgressDialog(context);

    final url = Uri.https(_url, '/api/auth/loginWithGoogle');
    final data = {"uid": uid, "name": name, "phone": phone, "newUser": newUser};
    if (phone == null) {
      phone = '';
    }
    var response = await http.post(url, body: json.encode(data));

    final decodeData = json.decode(response.body);
    print(response);
    final respDecode = jsonDecode(response.body);
    // loginModal.code = respDecode["codigo"];

    if (respDecode["message"] == "Login exitoso") {
      return respDecode["token"];
    } else {
      return respDecode["message"];
    }
  }
}

class LoginVerificationProvider {
  String token;

  final loginModal = new LoginModal();
  final _prefs = new PreferenciasUsuario();

  Future<List<dynamic>> verification(int code, String number) async {
    String url = "https://backend-delivery.azurewebsites.net/api/auth/verify";

    final resp = await http.post(Uri.parse(url), body: {
      "numero": number,
      "codigo": code.toString(),
    });

    Map<String, dynamic> respDecode = jsonDecode(resp.body);

    print(respDecode);
    if (respDecode["message"] == "verificacion completada") {
      _prefs.token = respDecode["token"];
      print("TOKEN 1 : ====" + _prefs.token);
      return [true, respDecode["token"], respDecode["user"]];
    } else {
      return [false];
    }
  }
}
