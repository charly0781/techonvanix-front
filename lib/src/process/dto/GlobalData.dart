import 'dart:convert';

import '../../service/ApiService.dart';
import 'ApiResponse.dart';

class GlobalData {

  static Map<String, dynamic>? companyData;
  static List<dynamic>? allUrls;
  static String token = "eyJhbGciOiJIUzI1NiJ9.eyJlc3RhZG8iOiJBQ1RJVk8iLCJyb2xlIjoiU1VQUE9SVCIsImNvbXBhbmlhIjo5OSwidXNlck5hbWUiOiJuby1yZXBseUB0ZWNob252YW5peC5jb20iLCJpYXQiOjE3Mzc5MDk4NzIsImV4cCI6MTczNzk5NjI3Mn0._f1BgnJVO5Owu_1l1bC4JMa0iSff-CG1AshSvUP65fY";


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
