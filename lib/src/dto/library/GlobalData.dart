import 'dart:convert';

import '../../service/ApiService.dart';
import 'ApiResponse.dart';

class GlobalData {

  static Map<String, dynamic>? companyData;
  static List<dynamic>? allUrls;
  static List<dynamic>? allMenus;
  static String token = "eyJhbGciOiJIUzI1NiJ9.eyJlc3RhZG8iOiJBQ1RJVk8iLCJyb2xlIjoiR1VFU1QiLCJjb21wYW5pYSI6OTksInVzZXJOYW1lIjoiY2FybG9zUmlvc0B0ZWNob252YW5peC5jb20iLCJpYXQiOjE3Mzg1ODUzMDEsImV4cCI6MTczODY3MTcwMX0.lGPyLjJ7-hNOylIZfwMiESia_ifCQcMp5a1lVVz_vzo";
  static String userName = "";

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
