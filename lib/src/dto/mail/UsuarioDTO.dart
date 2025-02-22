
import 'TipoDTO.dart';

class UsuarioDTO {
  String? id;
  String nit;
  TipoDTO tipoDocumentoId;
  TipoDTO tipoEstado;
  String email;
  int celular;
  int whatsApp;
  int telefono;
  String nombre;
  String apellido;
  String alias;
  String fechaNacimiento;
  String fechaRegistro;
  double saldo;
  String direccion;
  String password;
  int idComania;

  UsuarioDTO({
    this.id, // No es obligatorio
    required this.nit,
    required this.tipoDocumentoId,
    required this.tipoEstado,
    required this.email,
    required this.celular,
    required this.whatsApp,
    required this.telefono,
    required this.nombre,
    required this.apellido,
    required this.alias,
    required this.fechaNacimiento,
    required this.fechaRegistro,
    required this.saldo,
    required this.direccion,
    required this.password,
    required this.idComania,
  });

  factory UsuarioDTO.fromJson(Map<String, dynamic> json) {
    return UsuarioDTO(
      id: json['id'],
      nit: json['nit'],
      tipoDocumentoId: TipoDTO.fromJson(json['tipoDocumentoId']),
      tipoEstado: TipoDTO.fromJson(json['tipoEstado']),
      email: json['email'],
      celular: json['celular'],
      whatsApp: json['whatsApp'],
      telefono: json['telefono'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      alias: json['alias'],
      fechaNacimiento: json['fechaNacimiento'],
      fechaRegistro: json['fechaRegistro'],
      saldo: json['saldo'].toDouble(),
      direccion: json['direccion'],
      password: json['password'],
      idComania: json['idComania'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nit': nit,
      'tipoDocumentoId': tipoDocumentoId.toJson(),
      'tipoEstado': tipoEstado.toJson(),
      'email': email,
      'celular': celular,
      'whatsApp': whatsApp,
      'telefono': telefono,
      'nombre': nombre,
      'apellido': apellido,
      'alias': alias,
      'fechaNacimiento': fechaNacimiento,
      'fechaRegistro': fechaRegistro,
      'saldo': saldo,
      'direccion': direccion,
      'password': password,
      'idComania': idComania,
    };
  }
}

