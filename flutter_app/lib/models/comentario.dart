class Comentario {
  final int id;
  final int reporteId;
  final int usuarioId;
  final String usuario;
  final String comentario;
  final String? archivoUrl;
  final DateTime fecha;

  Comentario({
    required this.id,
    required this.reporteId,
    required this.usuarioId,
    required this.usuario,
    required this.comentario,
    this.archivoUrl,
    required this.fecha,
  });

  factory Comentario.fromJson(Map<String, dynamic> json) {
    return Comentario(
      id: json['id'],
      reporteId: json['reporte_id'],
      usuarioId: json['usuario_id'],
      usuario: json['usuario'] ?? '',
      comentario: json['comentario'],
      archivoUrl: json['archivo_url'],
      fecha: DateTime.parse(json['fecha']),
    );
  }
}

