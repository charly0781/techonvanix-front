import 'AdjuntosDto.dart';

class DestinatarioDto {
  String email;
  String empresa;
  String name;
  String identificacion;
  String id;
  Map<String, dynamic> replaceData;
  List<AdjuntosDto> adjuntos;

  DestinatarioDto({
    required this.email,
    required this.empresa,
    required this.name,
    required this.identificacion,
    required this.id,
    required this.replaceData,
    required this.adjuntos,
  });

  factory DestinatarioDto.fromJson(Map<String, dynamic> json) {
    return DestinatarioDto(
      email: json['email'],
      empresa: json['empresa'],
      name: json['name'],
      identificacion: json['identificacion'],
      id: json['id'],
      replaceData: json['replaceData'] ?? {},
      adjuntos: (json['adjuntos'] as List<dynamic>?)?.map((e) => AdjuntosDto.fromJson(e)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'empresa': empresa,
      'name': name,
      'identificacion': identificacion,
      'id': id,
      'replaceData': replaceData,
      'adjuntos': adjuntos.map((e) => e.toJson()).toList(),
    };
  }
}
