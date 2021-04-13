abstract class Usuario {
  int numero;
}

class RegistroModal extends Usuario {
  String nombre;
  String apellido;
  String email;

  RegistroModal({
    this.nombre,
    this.apellido,
    this.email,
  });
}
