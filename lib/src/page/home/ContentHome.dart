import 'dart:math';
import 'package:flutter/material.dart';
import 'package:techonvanix/src/page/home/ShowTooltip.dart';
import 'package:techonvanix/src/page/transversal/MessageDialog.dart';
import 'package:techonvanix/src/process/dto/ApiResponse.dart';
import 'package:techonvanix/src/service/Utilitarios.dart';

class ContentHome extends StatefulWidget {
  const ContentHome({Key? key}) : super(key: key);

  @override
  _ContentHomeState createState() => _ContentHomeState();
}

class _ContentHomeState extends State<ContentHome> {
  final String codeUrl = "geturlMenu";
  late Future<ApiResponse> _apiResponseFuture;

  int code = 0;
  double posH = 2.5;
  double posV = 2.0;
  double sizeCircle = 150.0;
  double sizeChildren = 40.0;
  double radiosDistance = 200.0;
  double postScreemX = 70.0;
  double postScreemY = 70.0;
  String title = "Default Title";
  String content = "Default Content";
  List<Map<String, dynamic>> contentItems = [];
  List<Map<String, dynamic>> temp = [];

  @override
  void initState() {
    super.initState();
    _apiResponseFuture = _fetchData();
  }

  Future<ApiResponse> _fetchData() async {
    Map<String, String> replacements = {"code": "homepage"};

    final ApiResponse response = await Utilitarios.realizarPeticion(
      tipoPeticion: "GET",
      codigo: codeUrl,
      parametros: replacements,
    );

    if (response.code == 200 && response.body != null) {
      final data = response.body;
      code = response.code;
      // Actualizar los valores dinámicos con los datos de la API
      setState(() {
        posH = data['posH'] ?? posH;
        posV = data['posV'] ?? posV;
        sizeCircle = data['sizeCircle'] ?? sizeCircle;
        sizeChildren = data['sizeChildren'] ?? sizeChildren;
        radiosDistance = data['radiosDistance'] ?? radiosDistance;
        postScreemX = data['postScreemX'] ?? postScreemX;
        postScreemY = data['postScreemY'] ?? postScreemY;
        title = data['title'] ?? title;
        content = data['content'] ?? content;
        contentItems = List<Map<String, dynamic>>.from(
          data['menu']?.where((element) => element['active'] == true) ?? [],
        );
      });
    }

    if (code != 200){
      MessageDialog.showMessage(context, title: "Home Page",
      message: response.message, confirmButtonText: "Aceptar");
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse>(
      future: _apiResponseFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (code != 200) {
          return Scaffold(
            appBar: AppBar(title: const Text("Error")),
            body: const Center(
              child: Text("Error al cargar los datos del servidor."),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Círculo central
                Positioned(
                  left: MediaQuery.of(context).size.width / posV - postScreemX,
                  top: MediaQuery.of(context).size.height / posH - postScreemY,
                  child: Container(
                    width: sizeCircle,
                    height: sizeCircle,
                    child: CircleAvatar(
                      radius: sizeCircle,
                      backgroundImage: const AssetImage('lib/src/img/logo2.jpg'),
                    ),
                  ),
                ),
                ..._generateTentacles(context),
              ],
            ),
          ),
        );
      },
    );
  }


  List<Widget> _generateTentacles(BuildContext context) {
    final double centerRadius = radiosDistance;
    final double itemRadius = sizeChildren;
    final double angleStep = 360 / contentItems.length;
    List<Widget> widgets = [];

    // Generar hijos ("tentáculos") alrededor del círculo central
    for (int i = 0; i < contentItems.length; i++) {
      final double angle = angleStep * i;
      final double radians = angle * (pi / 180);

      // Calcular posiciones basadas en el ángulo y el radio
      final double x = centerRadius * cos(radians);
      final double y = centerRadius * sin(radians);

      widgets.add(
        Positioned(
          left: (MediaQuery.of(context).size.width / posV) + x - itemRadius,
          top: (MediaQuery.of(context).size.height / posH) + y - itemRadius,

          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => Showtooltip.showTooltip(context, contentItems[i]["legend"]),
            child: GestureDetector(
              onTap: () {
                _navigateToClass(context, contentItems[i]["className"]);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: itemRadius,
                    backgroundImage: AssetImage(contentItems[i]["urlImage"] ?? ''),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    contentItems[i]["title"] ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  // Método para navegar a las clases
  void _navigateToClass(BuildContext context, String? className) {
    if (className == null || className.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Clase no definida.")),
      );
      return;
    }

    // Agregar rutas según la clase
    if (className == "PreferenosPage") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PreferenosPage()),
      );
    } else if (className == "PorQuePreferirnosPage") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PorQuePreferirnosPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No se encontró la clase $className")),
      );
    }
  }
}

class PorQuePreferirnosPage extends StatelessWidget {
  const PorQuePreferirnosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("¿Por qué preferirnos?")),
      body: const Center(child: Text("Contenido de ¿Por qué preferirnos?")),
    );
  }
}


class PreferenosPage extends StatelessWidget {
  const PreferenosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prefierenos")),
      body: const Center(child: Text("Contenido de Prefierenos")),
    );
  }

}

// Método para mostrar una leyenda como Tooltip al pasar el mouse
