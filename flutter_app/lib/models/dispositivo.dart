class Dispositivo {
  final int id;
  final String tipo;
  final String ubicacion;
  final String estado;
  final double consumo;

  Dispositivo({
    required this.id,
    required this.tipo,
    required this.ubicacion,
    required this.estado,
    required this.consumo,
  });

  factory Dispositivo.fromJson(Map<String, dynamic> json) {
    return Dispositivo(
      id: json['id'],
      tipo: json['tipo'],
      ubicacion: json['ubicacion'],
      estado: json['estado'],
      consumo: (json['consumo'] as num).toDouble(),
    );
  }
}

