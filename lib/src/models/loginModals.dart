// To parse this JSON data, do
//
//     final loginModal = loginModalFromJson(jsonString);

import 'dart:convert';

//Recibir Json
LoginModal loginModalFromJson(String str) =>
    LoginModal.fromJson(json.decode(str));

String loginModalToJson(LoginModal data) => json.encode(data.toJson());

class LoginModal {
  int numero;

  LoginModal({
    this.numero,
  });

  factory LoginModal.fromJson(Map<String, dynamic> json) => LoginModal(
        numero: json["numero"],
      );

  Map<String, dynamic> toJson() => {
        "numero": numero,
      };
}
