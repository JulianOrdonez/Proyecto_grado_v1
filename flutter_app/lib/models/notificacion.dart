class Notificacion {
  final int id;
  final int usuarioId;
  final String mensaje;
  final String tipo;
  final bool leida;
  final DateTime fecha;

  Notificacion({
    required this.id,
    required this.usuarioId,
    required this.mensaje,
    required this.tipo,
    required this.leida,
    required this.fecha,
  });

  factory Notificacion.fromJson(Map<String, dynamic> json) {
    return Notificacion(
      id: json['id'],
      usuarioId: json['usuario_id'],
      mensaje: json['mensaje'],
      tipo: json['tipo'] ?? '',
      leida: json['leida'] == 1 || json['leida'] == true,
      fecha: DateTime.parse(json['fecha']),
    );
  }
}

