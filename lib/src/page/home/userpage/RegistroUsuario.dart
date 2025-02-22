
import 'package:flutter/cupertino.dart';
import 'package:techonvanix/src/dto/library/ApiResponse.dart';
import 'package:techonvanix/src/dto/library/GlobalData.dart';
import 'package:techonvanix/src/dto/mail/UsuarioDTO.dart';
import 'package:techonvanix/src/service/EnumServicio.dart';
import '../../../dto/mail/TipoDTO.dart';
import '../../../service/Utilitarios.dart';

import 'package:flutter/material.dart';

class RegistroUsuario {
    final Map<String, dynamic> datos;

    RegistroUsuario(this.datos);

    Future<ApiResponse> registrarUsuario() async {
        try {

            TipoDTO tipoDoc = await _getEstado(datos['tipoDocumento'].toString(), 'getTipo');
            TipoDTO estado = await _getEstado('TC_ESTADOINACTIVO', 'getTipo');

            UsuarioDTO usuario = UsuarioDTO(
                nit: datos['nit'],
                tipoDocumentoId: tipoDoc,
                tipoEstado: estado,
                email: datos['email'],
                celular: datos['celular'],
                whatsApp: datos['whatsapp'],
                telefono: datos['celular'],
                nombre: datos['nombre'],
                apellido: datos['apellido'],
                alias: datos['alias'],
                fechaNacimiento: datos['fechaNacimiento'],
                fechaRegistro: DateTime.now().toString(),
                saldo: 0,
                direccion: datos['direccion'],
                password: datos['password'],
                idComania: GlobalData.companyData?['id'],
            );

            return _saveData(usuario);
        } catch (e) {
            return ApiResponse(code: -1, message: 'Error en el registro: $e', body: {});
        }
    }

    /// Método para obtener estado/tipo de documento
    static Future<TipoDTO> _getEstado(String codigo, String endpoint) async {
        final ApiResponse response = await Utilitarios.realizarPeticion(
            tipoPeticion: EnumParam.GET.value,
            codigo: endpoint,
            parametros: {"codigo": codigo},
        );

        if (response.code == 200 && response.body != null) {
            return TipoDTO.fromJson(response.body[0]); // Tomar el primer resultado
        }
        throw Exception("No se encontró el estado o tipo de documento");
    }

    // Método para guardar los datos del usuario
    static Future<ApiResponse> _saveData(UsuarioDTO usuario) async {

        final ApiResponse response = await Utilitarios.realizarPeticion(
            tipoPeticion: EnumParam.POST.value,
            codigo: "userCreate",
            parametros: usuario.toJson(),
        );

        return ApiResponse(code: response.code, message: response.message,
            body: response.body);
    }
}
