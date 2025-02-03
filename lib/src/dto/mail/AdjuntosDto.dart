
class AdjuntosDto {
  String file;
  String formato;
  String nombre;

  AdjuntosDto({
    required this.file,
    required this.formato,
    required this.nombre,
  });

  factory AdjuntosDto.fromJson(Map<String, dynamic> json) {
    return AdjuntosDto(
      file: json['file'],
      formato: json['formato'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'file': file,
      'formato': formato,
      'nombre': nombre,
    };
  }
}
