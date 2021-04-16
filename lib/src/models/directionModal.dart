class DirectionModal {
  String id;
  String direction;
  String usuario_id;

  DirectionModal({this.id, this.direction, this.usuario_id});

  DirectionModal.fromJsonMap(Map<String, dynamic> json) {
    id = json['_id'];
    direction = json['direccion'];
    usuario_id = json['usuario_id'];
  }
}

class DirectionModals {
  // ignore: deprecated_member_use
  final List<DirectionModal> direcciones = new List();
  DirectionModals();
  DirectionModals.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final direccion = new DirectionModal.fromJsonMap(item);
      direcciones.add(direccion);
    }
  }
}
