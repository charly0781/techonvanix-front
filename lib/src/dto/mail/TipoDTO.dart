
import 'TipoCategoriaDTO.dart';

class TipoDTO {
  int id;
  TipoCategoriaDTO tipoPadreId;
  String codigo;
  String nombre;
  int orden;
  String valor;
  int cantidad;

  // Constructor principal
  TipoDTO({
    required this.id,
    required this.tipoPadreId,
    required this.codigo,
    required this.nombre,
    required this.orden,
    required this.valor,
    required this.cantidad,
  });

  factory TipoDTO.iniciarClase() {
    return TipoDTO(
      id: 0,
      tipoPadreId: TipoCategoriaDTO(id: 0,  codigo: "", nombre: ""),
      codigo: "",
      nombre: "",
      orden: 0,
      valor: "",
      cantidad: 0,
    );
  }

  factory TipoDTO.fromJson(Map<String, dynamic> json) {
    return TipoDTO(
      id: json['id'],
      tipoPadreId: TipoCategoriaDTO.fromJson(json['tipoPadre']),
      codigo: json['codigo'],
      nombre: json['nombre'],
      orden: json['orden'],
      valor: json['valor'],
      cantidad: json['cantidad'],
    );
  }

  // Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipoPadreId': tipoPadreId.toJson(),
      'codigo': codigo,
      'nombre': nombre,
      'orden': orden,
      'valor': valor,
    };
  }
}
