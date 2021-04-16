import 'package:flutter/foundation.dart';

class InfoProvider with ChangeNotifier {
  String _token;
  int _number;
  String _idDirection;
  String _direccion = "Escoja su direccion";

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
