import 'package:app_restaurante/src/models/categoryModal.dart';
import 'package:app_restaurante/src/models/platoModel.dart';
import 'package:flutter/foundation.dart';

class InfoProvider with ChangeNotifier {
  String _idDirection;
  String _idUsuario;
  String _idPedido;
  String _nombre;
  String _apellido;
  String _direccion = "Escoja su direccion";
  String _token;
  int _number;

  List<Plato> _platos = [];
  List<CategoryModal> _categorias = [];

  get idPedido {
    return _idPedido;
  }

  set idPedido(String id) {
    this._idPedido = id;
  }

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

  set idDirection(String idDirection) {
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

  get idUsuario {
    return _idUsuario;
  }

  set idUsuario(String idUsuario) {
    this._idUsuario = idUsuario;
  }

  get nombre {
    return _nombre;
  }

  set nombre(String nombre) {
    this._nombre = nombre;
  }

  get apellido {
    return _apellido;
  }

  set apellido(String apellido) {
    this._apellido = apellido;
  }

  @override
  void notifyListeners();
}
