import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

import '../../../dto/library/ApiResponse.dart';
import '../../../dto/library/GlobalData.dart';
import '../../../service/EnumServicio.dart';
import '../../../service/Utilitarios.dart';

class PlanesPage extends StatefulWidget {
  final List<Map<String, dynamic>> menu;
  PlanesPage({required this.menu});

  @override
  _PlanesPageState createState() => _PlanesPageState();
}

class _PlanesPageState extends State<PlanesPage> {
  late Map<String, dynamic> dataPage;
  List<Map<String, dynamic>> plans = [];
  int selectedPlanIndex = 0;

  final List<Map<String, String>> planes = [
    {
      "nombre": "Básico",
      "descripcion": "Ideal para pequeñas empresas que necesitan enviar correos ocasionalmente.",
      "detalles": "<p><strong>Plan Básico</strong></p><p>✔ Hasta 5,000 correos al mes</p><p>✔ Reportes básicos</p><p>✔ Soporte estándar</p>"
    },
    {
      "nombre": "Estándar",
      "descripcion": "Para negocios en crecimiento con mayor necesidad de envíos.",
      "detalles": "<p><strong>Plan Estándar</strong></p><p>✔ Hasta 50,000 correos al mes</p><p>✔ Reportes avanzados</p><p>✔ Integraciones con API</p>"
    },
    {
      "nombre": "Premium",
      "descripcion": "Para grandes empresas con requerimientos avanzados y envíos masivos.",
      "detalles": "<p><strong>Plan Premium</strong></p><p>✔ Correos ilimitados</p><p>✔ Soporte prioritario</p><p>✔ Seguridad avanzada</p>"
    },
  ];

  @override
  void initState() {
    super.initState();
    dataPage = widget.menu.firstWhere(
          (data) =>
      data['active'] == true &&
          data['tipo'] == 'H' &&
          data['title'].toString() == 'Planes',
      orElse: () => {"title": "Planes", "content": "", "legend": "Planes"},
    );

    getPlanes();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        screenWidth > 670 ? 90 : 20,
        40,
        screenWidth > 670 ? 90 : 20,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              dataPage['legend'].toString(),
              style: GoogleFonts.poppins(
                fontSize: screenWidth > 670 ? 34 : 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigoAccent,
              ),
            ),
          ),
          SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card con la lista de planes
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Container(
                  width: screenWidth > 670 ? 250 : 180,
                  height: 250, // Altura fija
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.builder(
                    itemCount: plans.isNotEmpty ? plans.length : planes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          plans.isNotEmpty
                          ? plans[index]["nombrePlan"]!
                          : planes[index]["nombre"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: selectedPlanIndex == index
                                ? Colors.blueAccent
                                : Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          plans.isNotEmpty
                              ? plans[index]["descripcion"]!
                              : planes[index]["descripcion"]!,
                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                        ),
                        onTap: () {
                          setState(() {
                            selectedPlanIndex = index;
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Html(
                      data: plans.isNotEmpty
                        ? utf8.decode(
                          (plans[selectedPlanIndex]["detallePlan"] as String).runes.toList(),
                          allowMalformed: true,
                          )
                        : planes[selectedPlanIndex]["detalles"]!,
                      style: {
                        "html": Style(
                          fontSize: FontSize(screenWidth > 670 ? 20 : 14),
                          fontFamily: 'monospace',
                        ),
                      },
                      onCssParseError: (css, messages) {
                        // Evita errores con selectores no soportados (como :hover)
                        return '';
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getPlanes() {
    Map<String, String> replacements =
    {
      "tipoPlan" : "TP_MAIL",
      "estado": "TC_ESTADOACTIVO"
    };
    Utilitarios.realizarPeticion(
        tipoPeticion: EnumParam.GET.value,
        codigo: "getAllPlans",
        parametros: replacements,
        token: GlobalData.token)
        .then((response) {
      if (response.code == 200 && response.body != null) {
        setState(() {
          plans.clear();
          plans.addAll((response.body as List)
              .map((item) => Map<String, dynamic>.from(item))
              .toList());
        });
      } else {
        _showErrorSnackbar(response.message);
      }
    });
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
