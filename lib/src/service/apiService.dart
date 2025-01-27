import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServicio {

  final String baseUrl;

  ApiServicio({required this.baseUrl});

  Future<http.Response> realizarPeticion({
    required String tipoPeticion,
    required String endpoint,
    Map<String, dynamic>? parametros,
    String? token,
    Map<String, String>? customHeaders,
  }) async {

    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      ...?customHeaders,
    };

    String urlFinal = endpoint;
    if (parametros != null && endpoint.contains("#")) {
      urlFinal = _reemplazarParametros(endpoint, parametros);
    }
    final uri = Uri.parse('$baseUrl$urlFinal');

    print("Peticion " + tipoPeticion.toString());
    print("URL  " + uri.toString());

    // Determinar la petición según tipoPeticion
    switch (tipoPeticion.toUpperCase()) {
      case 'GET':
        return await http.get(uri, headers: headers);

      case 'POST':
        return await http.post(uri, headers: headers, body: jsonEncode(parametros));

      case 'PUT':
        return await http.put(uri, headers: headers, body: jsonEncode(parametros));

      case 'DELETE':
        if (parametros != null && endpoint.contains('#')) {
          // DELETE con parámetros en la URL
          return await http.delete(uri, headers: headers);
        } else if (parametros != null ) {
          // DELETE con body
          return await http.delete(uri, headers: headers, body: jsonEncode(parametros));
        } else {
          return await http.delete(uri, headers: headers);
        }

      default:
        throw Exception('Tipo de petición no soportado: $tipoPeticion');
    }
  }

  // Método para reemplazar placeholders en la URL
  String _reemplazarParametros(String endpoint, Map<String, dynamic> parametros) {
    String nuevaUrl = endpoint;
    parametros.forEach((clave, valor) {
      nuevaUrl = nuevaUrl.replaceAll('#$clave', valor.toString());
    });
    return nuevaUrl;
  }
}
