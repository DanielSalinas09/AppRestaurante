import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  get numero {
    return _prefs.getString('numero') ?? '';
  }

  set numero(int value) {
    _prefs.setString('numero', value.toString());
  }

  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get idPedido {
    return _prefs.getString('idPedido') ?? '';
  }

  set idPedido(String value) {
    _prefs.setString('idPedido', value);
  }

  get nombre {
    return _prefs.getString('nombre') ?? '';
  }

  set nombre(String value) {
    _prefs.setString('nombre', value);
  }

  get apellido {
    return _prefs.getString('apellido') ?? '';
  }

  set apellido(String value) {
    _prefs.setString('apellido', value);
  }

  get idUsuario {
    return _prefs.getString('idUsuario') ?? '';
  }

  set idUsuario(String value) {
    _prefs.setString('idUsuario', value);
  }

  get estado {
    return _prefs.getString('estado') ?? 'disponible';
  }

  set estado(String value) {
    _prefs.setString('estado', value);
  }

  get idDirection {
    return _prefs.getString('idDirection') ?? '';
  }

  set idDirection(String value) {
    _prefs.setString('idDirection', value);
  }

  get direction {
    return _prefs.getString('direction') ?? 'Escoja su direccion';
  }

  set direction(String value) {
    _prefs.setString('direction', value);
  }
}
