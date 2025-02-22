

class TipoCategoriaDTO {
  int id;
  String codigo;
  String nombre;

  // Constructor principal
  TipoCategoriaDTO({
  required this.id,
  required this.codigo,
  required this.nombre,
  });

  // Método para inicializar la clase con valores predeterminados
  factory TipoCategoriaDTO.iniciarClase() {
  return TipoCategoriaDTO(
  id: 0,
  codigo: "",
  nombre: "",
  );
  }

  // Método para crear un objeto desde un JSON
  factory TipoCategoriaDTO.fromJson(Map<String, dynamic> json) {
  return TipoCategoriaDTO(
    id: json['id'],
    codigo: json['codigo'],
    nombre: json['nombre'],
  );
  }

  // Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
  return {
  'id': id,
  'codigo': codigo,
  'nombre': nombre,
  };
  }
  }
