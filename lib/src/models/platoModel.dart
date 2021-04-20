// Generated by https://quicktype.io

class Plato {
  String id;
  String nombre;
  int precio;
  Map categoryId;
  String imgUri;
  String ingredientes;
  int cantidad;
  Plato({
    this.id,
    this.nombre,
    this.precio,
    this.categoryId,
    this.imgUri,
    this.ingredientes,
    this.cantidad = 1,
  });

  Plato.fromJsonMap(Map<String, dynamic> json) {
    id = json['_id'];
    nombre = json['nombre'];
    precio = json['precio'];
    categoryId = json['category_id'];
    imgUri = json['img_uri'];
    ingredientes = json['ingredientes'];
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
