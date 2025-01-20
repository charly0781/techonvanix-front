import 'dart:math';
import 'package:flutter/material.dart';

class ContentHome extends StatelessWidget {
  final double posH = 2.4;
  final double posV = 2;
  final double sizeCircle = 200.0;
  final double sizeChildren = 50.0;
  final double radiosDistance = 250.0;
  final double postScreemX = 100.0;
  final double postScreemY = 100.0;
  final List<Map<String, dynamic>> contentItems = [
    {
      "title": "Prefierenos",
      "leyenda": "Agradecemos la confianza",
      "imageUrl": "lib/src/img/logoSF.png",
      "content": "Razones para preferirnos...",
      "className": "PreferenosPage",
    },
    {
      "title": "¿Por qué preferirnos?",
      "leyenda": "Agradecemos la confianza",
      "imageUrl": "lib/src/img/app_icon.png",
      "content": "Nuestra calidad nos define...",
      "className": "PorQuePreferirnosPage",
    },
    {
      "title": "¿Por qué preferirnos?",
      "leyenda": "Agradecemos la confianza",
      "imageUrl": "lib/src/img/app_icon.png",
      "content": "Nuestra calidad nos define...",
      "className": "PorQuePreferirnosPage",
    },
    {
      "title": "¿Por qué preferirnos?",
      "leyenda": "Agradecemos la confianza",
      "imageUrl": "lib/src/img/app_icon.png",
      "content": "Nuestra calidad nos define...",
      "className": "PorQuePreferirnosPage",
    },

  ];

  ContentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: MediaQuery.of(context).size.width / posV - postScreemX,
              top: MediaQuery.of(context).size.height / posH - postScreemY,
              child: Container(
                width: sizeCircle,
                height: sizeCircle,
                child: CircleAvatar(
                  radius: sizeCircle,
                  backgroundImage: AssetImage('lib/src/img/logo2.jpg'),
                ),
              ),
            ),
            ..._generateTentacles(context),
          ],
        ),
      ),
    );
  }

  // Método para generar los círculos hijos ("tentáculos")
  List<Widget> _generateTentacles(BuildContext context) {
    final double centerRadius = radiosDistance; // Radio para los "tentáculos"
    final double itemRadius = sizeChildren;    // Radio de los hijos
    final double angleStep = 360 / contentItems.length; // Ángulo entre cada hijo
    List<Widget> widgets = [];

    // Generar hijos ("tentáculos") alrededor del círculo central
    for (int i = 0; i < contentItems.length; i++) {
      final double angle = angleStep * i; // Ángulo actual en grados
      final double radians = angle * (pi / 180); // Convertir a radianes

      // Calcular posiciones basadas en el ángulo y el radio
      final double x = centerRadius * cos(radians);
      final double y = centerRadius * sin(radians);

      widgets.add(
        Positioned(
          left: (MediaQuery.of(context).size.width / posV) + x - itemRadius,
          top: (MediaQuery.of(context).size.height / posH) + y - itemRadius,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  _navigateToClass(context, contentItems[i]["className"]);
                },
                child: CircleAvatar(
                  radius: itemRadius,
                  backgroundImage: AssetImage(contentItems[i]["imageUrl"] ?? ''),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                contentItems[i]["title"],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }

    return widgets;
  }

  // Método para navegar a las clases
  void _navigateToClass(BuildContext context, String className) {
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
