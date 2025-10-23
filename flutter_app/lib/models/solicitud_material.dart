class SolicitudMaterial {
  final int id;
  final int usuarioId;
  final String tipoMaterial;
  final int cantidad;
  final String descripcion;
  final String estado;
  final DateTime fecha;
  final DateTime? fechaResolucion;

  SolicitudMaterial({
    required this.id,
    required this.usuarioId,
    required this.tipoMaterial,
    required this.cantidad,
    required this.descripcion,
    required this.estado,
    required this.fecha,
    this.fechaResolucion,
  });

  factory SolicitudMaterial.fromJson(Map<String, dynamic> json) {
    return SolicitudMaterial(
      id: json['id'],
      usuarioId: json['usuario_id'],
      tipoMaterial: json['tipo_material'],
      cantidad: json['cantidad'],
      descripcion: json['descripcion'] ?? '',
      estado: json['estado'],
      fecha: DateTime.parse(json['fecha']),
      fechaResolucion: json['fecha_resolucion'] != null ? DateTime.parse(json['fecha_resolucion']) : null,
    );
  }
}

