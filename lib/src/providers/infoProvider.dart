import 'package:app_restaurante/src/models/categoryModal.dart';
import 'package:app_restaurante/src/models/platoModel.dart';
import 'package:flutter/foundation.dart';

class InfoProvider with ChangeNotifier {
  
  String _token;
  int _number;
  String _idDirection;
  String _direccion = "Escoja su direccion";
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

  get direction {
    return _direccion;
  }

  set direction(String direction) {
    this._direccion = direction;
  }

  get idDirection {
    return _idDirection;
  }

  set idDirection(idDirection) {
    this._idDirection = idDirection;
  }

  get number {
    return _number;
  }

  set number(int number) {
    this._number = number;
  }

  get token {
    return _token;
  }

  set token(String value) {
    this._token = value;
  }

  @override
  void notifyListeners();
}
