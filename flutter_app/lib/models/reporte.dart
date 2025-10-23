class Reporte {
  final int? id;
  final int usuarioId;
  final String salon;
  final String descripcion;
  final String estado;
  final DateTime fecha;
  final String edificio;
  final String dependencia;
  final String tipoAula;
  final int sillas;

  Reporte({
    this.id,
    required this.usuarioId,
    required this.salon,
    required this.descripcion,
    required this.estado,
    required this.fecha,
    required this.edificio,
    required this.dependencia,
    required this.tipoAula,
    required this.sillas,
  });

  factory Reporte.fromJson(Map<String, dynamic> json) {
    return Reporte(
      id: json['id'],
      usuarioId: json['usuario_id'],
      salon: json['salon'],
      descripcion: json['descripcion'],
      estado: json['estado'],
      fecha: DateTime.parse(json['fecha']),
      edificio: json['edificio'] ?? '',
      dependencia: json['dependencia'] ?? '',
      tipoAula: json['tipo_aula'] ?? '',
      sillas: json['sillas'] ?? 0,
    );
  }
}
