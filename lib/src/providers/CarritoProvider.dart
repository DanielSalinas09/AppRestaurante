import 'package:flutter/material.dart';
import 'package:app_restaurante/src/models/platoModel.dart';

class CarritoProvider extends ChangeNotifier {
  Map<String, Plato> _items = {};

  int _total = 0;
  List<String> dato = [];

  List<String> get datos {
    return dato;
  }

  Map<String, Plato> get items {
    return {..._items};
  }

  int get numeroItems {
    return _items.length;
  }

  int get total {
    _total = 0;

    _items.forEach((key, value) {
      _total = _total + value.precio * value.cantidad;
    });
    return _total;
  }

  void agregarItem(String id, String nombre, int precio, int cantidad) {
    if (_items.containsKey(id)) {
      print(_items);
      // update(K key, V update(V value), {V ifAbsent()?});
      _items.update(
          id,
          (plato) => Plato(
              id: id, nombre: nombre, precio: precio, cantidad: cantidad));
    } else {
      print(id);
      print(nombre);
      print(precio);
      print(cantidad);
      _items.putIfAbsent(
          id,
          () => Plato(
              id: id, nombre: nombre, precio: precio, cantidad: cantidad));
    }
  }

  void removerItem(String id) {
    _items.remove(id);
  }

  void vaciarCarrito() {
    _items = {};
  }

  void realizarPedido() {
    dato.clear();
    _items.forEach((key, value) {
      print(key);
      print(value.cantidad);
      for (int i = 0; i < value.cantidad; i++) {
        print(i.toString() + "posiscion" + key);
        dato.add(key);
      }
    });
    print(dato);
  }

  @override
  void notifyListeners();
}
