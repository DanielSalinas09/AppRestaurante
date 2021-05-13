import 'package:app_restaurante/src/models/categoryModal.dart';
import 'package:app_restaurante/src/models/platoModel.dart';

import 'package:flutter/foundation.dart';

class InfoProvider with ChangeNotifier {
  List<Plato> _platos = [];
  List<CategoryModal> _categorias = [];

  List<CategoryModal> get categoria {
    return _categorias;
  }

  set categoria(List<CategoryModal> categorias) {
    this._categorias = categorias;
  }

  List<Plato> get plato {
    return _platos;
  }

  set plato(List<Plato> platos) {
    this._platos = platos;
  }

  @override
  void notifyListeners();
}
