import 'dart:convert';

import '../../service/ApiService.dart';
import 'ApiResponse.dart';

class GlobalData {

  static Map<String, dynamic>? companyData;
  static List<dynamic>? allUrls;
  static List<dynamic>? allMenus;
  static String token = "eyJhbGciOiJIUzI1NiJ9.eyJlc3RhZG8iOiJBQ1RJVk8iLCJyb2xlIjoiU1VQUE9SVCIsImNvbXBhbmlhIjo5OSwidXNlck5hbWUiOiJuby1yZXBseUB0ZWNob252YW5peC5jb20iLCJpYXQiOjE3Mzg3NTc1NTksImV4cCI6MTczODg0Mzk1OX0.g2C9SZqNGezz6J1FY1K6s4L32Gv7OP5EFRFJbbznz1I";
  static String userName = "carlosRios";

  static Future<void> initializeData(ApiServicio apiServicio) async {

    final responseCompany = await apiServicio.realizarPeticion(
      tipoPeticion: 'GET',
      endpoint: '/techonvanix-services/v1/compania/getComapany?identificacion=999999999',
    );

      final companyResponse = ApiResponse.fromJson(jsonDecode(responseCompany.body));
      if (companyResponse.code == 200) {
          GlobalData.companyData = companyResponse.body[0] as Map<String, dynamic>;

      } else {
        throw Exception('Error en getCompany: ${companyResponse.message}');
      }

    final responseUrls = await apiServicio.realizarPeticion(
      tipoPeticion: 'GET',
      endpoint: '/techonvanix-services/v1/urlcontroller/allUrl?idCompania=99',
    );

    final urlsResponse = ApiResponse.fromJson(jsonDecode(responseUrls.body));
    if (urlsResponse.code == 200) {
      allUrls = urlsResponse.body as List<dynamic>;
    } else {
      throw Exception('Error en allUrl: ${urlsResponse.message}');
    }
  }
}
