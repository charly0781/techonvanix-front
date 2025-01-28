import 'package:flutter/material.dart';
import '../../process/dto/GlobalData.dart';

import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  final String companyName = "Mi Empresa";

  final String contactEmail = "contacto@miempresa.com";
  final String contactPhone = "+123 456 7890";

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? companyData = GlobalData.companyData;

    return Scaffold(
      appBar: AppBar(
        title: Text(companyData?['alias']?.toString() ?? companyName),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          // Fondo con imagen que ocupa toda la pantalla
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.5),
                  BlendMode.dstATop,
                ),
                child: Image.network(
                  companyData?['urlFondo']?.toString() ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'lib/src/img/fondo.jpg',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          ),
          // Contenido central
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "404",
                  style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Text(
                  "Página no encontrada",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "¡Ups! Parece que te has perdido.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          // Pie de página con datos de contacto
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Contacto:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Email: ${companyData?['email']?.toString() ?? contactEmail}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "Teléfono: ${companyData?['celular']?.toString() ?? contactPhone}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
