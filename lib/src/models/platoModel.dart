// Generated by https://quicktype.io

import 'dart:convert';

class Plato {
  String id;
  String nombre;
  int precio;
  String categoryId;
  String imgUri;

  Plato({
    this.id,
    this.nombre,
    this.precio,
    this.categoryId,
    this.imgUri,
  });

  Plato.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    precio = json['precio'];
    categoryId = json['category_id'];
    imgUri = json['img_uri'];
  }
}

class Platos {
  // ignore: deprecated_member_use
  final List<Plato> platos = new List();
  Platos();
  Platos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final plato = new Plato.fromJsonMap(item);
      platos.add(plato);
    }
  }
}