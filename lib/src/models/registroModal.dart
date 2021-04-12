import 'dart:convert';

String registroModalToJson(RegistroModal data) => json.encode(data.toJson());

class RegistroModal {
  int numero;
  String nombre;
  String apellido;
  String email;

  RegistroModal({this.nombre, this.apellido, this.email, this.numero});

  Map<String, dynamic> toJson() => {
        'numero': numero,
        'nombre': nombre,
        'apellidos:': apellido,
        'email': email
      };
}
