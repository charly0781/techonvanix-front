import 'dart:math';
import 'package:flutter/material.dart';

class ContentHome extends StatelessWidget {
  final List<Map<String, dynamic>> contentItems = [
    {
      "title": "Prefierenos",
      "imageUrl": "https://img.fotocommunity.com/el-mundo-en-sus-manos-3a6c3dd3-95da-4de4-bb0b-ad79635ca741.jpg?height=100",
      "content": "Razones para preferirnos...",
      "className": "PreferenosPage",
    },
    {
      "title": "¿Por qué preferirnos?",
      "imageUrl": "https://img.fotocommunity.com/el-mundo-en-sus-manos-3a6c3dd3-95da-4de4-bb0b-ad79635ca741.jpg?height=100",
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
            CircleAvatar(
              radius: 60.0,
              backgroundImage: AssetImage('lib/src/img/logo2.jpg'),
            ),
            ..._generateTentacles(context),
          ],
        ),
      ),
    );
  }

  // Método para generar los círculos hijos ("tentáculos")
  List<Widget> _generateTentacles(BuildContext context) {
    final double centerRadius = 100.0; // Radio de distancia desde el centro
    final double itemRadius = 40.0; // Tamaño de los círculos hijos
    final double angleStep = 360 / contentItems.length; // Ángulo entre cada círculo
    List<Widget> widgets = [];

    for (int i = 0; i < contentItems.length; i++) {
      final double angle = angleStep * i; // Ángulo actual en grados
      final double radians = angle * (pi / 180); // Convertir a radianes

      // Calcular posiciones basadas en el ángulo y el radio
      final double x = centerRadius * cos(radians);
      final double y = centerRadius * sin(radians);

      widgets.add(
        Positioned(
          left: (MediaQuery.of(context).size.width / 2) + x - itemRadius,
          top: (MediaQuery.of(context).size.height / 2) + y - itemRadius,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  onTap: () {
                    _navigateToClass(context, contentItems[i]["className"]);
                  },
                  child: Image.network(
                    contentItems[i]["imageUrl"]?.toString() ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'lib/src/img/logo.png',
                        fit: BoxFit.cover,
                      );
                    },
                  )
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
