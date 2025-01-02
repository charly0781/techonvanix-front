import 'dart:math';

import 'package:flutter/material.dart';

class ContentHome extends StatelessWidget {
  final List<Map<String, dynamic>> contentItems = [
    {
      "title": "Prefierenos",
      "imageUrl": "https://img.fotocommunity.com/el-mundo-en-sus-manos-3a6c3dd3-95da-4de4-bb0b-ad79635ca741.jpg?height=100",
      "content": "Razones para preferirnos...",
      "className": "PreferenosPage", // Nombre de la clase para el contenido
    },
    {
      "title": "¿Por qué preferirnos?",
      "imageUrl": "https://img.fotocommunity.com/el-mundo-en-sus-manos-3a6c3dd3-95da-4de4-bb0b-ad79635ca741.jpg?height=100",
      "content": "Nuestra calidad nos define...",
      "className": "PorQuePreferirnosPage",
    },
    // Agregar más elementos aquí
  ];

  ContentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 80.0,
              backgroundImage: AssetImage('lib/src/img/logo2.jpg'), // Imagen del logo
            ),
            // Generar los tentáculos con los elementos
            ..._generateTentacles(context),
          ],
        ),
      ),
    );
  }

  // Método para generar los "tentáculos" con los elementos de la lista
  List<Widget> _generateTentacles(BuildContext context) {
    final double centerRadius = 120.0; // Radio del área central
    final double itemRadius = 40.0; // Radio de los círculos hijos
    final double angleStep = 360 / contentItems.length; // Ángulo entre elementos
    List<Widget> widgets = [];

    final double centerX = MediaQuery.of(context).size.width / 2;
    final double centerY = MediaQuery.of(context).size.height / 2;

    for (int i = 0; i < contentItems.length; i++) {
      final double angle = angleStep * i;
      final double radians = angle * (3.141592653589793 / 180); // Convertir a radianes

      final double x = centerX + centerRadius * cos(radians);
      final double y = centerY + centerRadius * sin(radians);

      widgets.add(
        Positioned(
          left: x - itemRadius,
          top: y - itemRadius,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  _navigateToClass(context, contentItems[i]["className"]);
                },
                child: CircleAvatar(
                  radius: itemRadius / 2,
                  backgroundImage: const AssetImage('lib/src/img/fondo.jpg'),
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

      // Dibujar la línea entre el centro y el elemento
      widgets.add(
        _buildLine(centerX, centerY, x, y),
      );
    }

    return widgets;
  }


  // Método para dibujar las líneas entre el centro y los círculos hijos
  Widget _buildLine(double x, double y, double radius, double radians) {
    return Positioned(
      left: MediaQueryData.fromView(WidgetsBinding.instance.window).size.width / 2,
      top: MediaQueryData.fromView(WidgetsBinding.instance.window).size.height / 2,
      child: Transform.rotate(
        angle: radians,
        child: Container(
          width: radius,
          height: 2,
          color: Colors.blue[800],
        ),
      ),
    );
  }

  // Método para navegar a la clase correspondiente
  void _navigateToClass(BuildContext context, String className) {
    // Ejemplo de navegación basada en el nombre de la clase
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
      // Página por defecto o error
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
