import 'dart:convert';
import 'package:techonvanix/src/process/dto/ApiResponse.dart';
import 'package:http/http.dart' as http;
import '../process/dto/GlobalData.dart';
import 'ApiService.dart';

class Utilitarios {

  static Future<ApiResponse> realizarPeticion({ required String tipoPeticion,
    required String codigo, Map<String, dynamic>? parametros, String? token,
    Map<String, String>? customHeaders,}) async {
    final List<dynamic>? allUrls = GlobalData.allUrls;

    String url = Utilitarios.getUrlData(allUrls, codigo, parametros);

    final apiServicio = ApiServicio(baseUrl: '');

    try {
      final http.Response response = await apiServicio.realizarPeticion(
          tipoPeticion: tipoPeticion,
          endpoint: url,
          parametros: parametros,
          token: token,
          customHeaders: customHeaders,
      );

      final Map<String, dynamic> decodedBody = jsonDecode(response.body);
      return ApiResponse(
        code: decodedBody['code'],
        message: decodedBody['message'] != null
            ? utf8.decode(decodedBody['message'].runes.toList())
            : ' ',
        body: decodedBody['body'],
      );
    } catch (e) {

      return ApiResponse(
        code: 500,
        message: 'Error al procesar la petición: $e',
        body: null,
      );
    }
  }

  /**
   * metodo obtner la url
   */
  static String getUrlData(List<dynamic>? allUrls,  String codigo,
      Map<String, dynamic>? replacements) {

      if (allUrls == null || allUrls.isEmpty) {
        return "";
      }

      final filteredData = allUrls.firstWhere(
            (element) => element['codigo'] == codigo,
        orElse: () => null,
      );

      if (filteredData == null) {
        return "";
      }

      // Construir la URL completa (host + url)
      final servidor = filteredData['servidor'];
      final String? host = servidor?['host'];
      final String? partialUrl = filteredData['url'];

      if (host == null || partialUrl == null) {
        return "";
      }

      String completeUrl = '$host$partialUrl';

      // Reemplazar dinámicamente las partes de la URL
      replacements?.forEach((key, value) {
        completeUrl = completeUrl.replaceAll('$key=#', '$key=$value');
      });

      return completeUrl;
    }

}
