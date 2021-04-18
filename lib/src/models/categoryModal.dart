class CategoryModal {
  String id;
  String nombre;

  CategoryModal(this.id, this.nombre);

  CategoryModal.fromJsonMap(Map<String, dynamic> json) {
    id = json['_id'];
    nombre = json['nombre'];
  }
}

class CategoriesModal {
  // ignore: deprecated_member_use
  final List<CategoryModal> categorys = new List();
  CategoriesModal();
  CategoriesModal.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final category = new CategoryModal.fromJsonMap(item);
      categorys.add(category);
    }
  }
}
