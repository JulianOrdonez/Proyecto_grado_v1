class Usuario {
  final int id;
  final String nombre;
  final String email;
  final String rol;

  Usuario({
    required this.id,
    required this.nombre,
    required this.email,
    required this.rol,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    final rawRol = (json['rol'] ?? '').toString();
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      rol: rawRol.trim().toLowerCase(),
    );
  }
}
