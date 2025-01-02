import 'package:flutter/material.dart';

class FooterHomePage extends StatelessWidget {
  const FooterHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[900],
      padding: const EdgeInsets.all(16.0),
      child: const Text(
        '© 2024 Techonanix. Todos los derechos reservados.',
        style: TextStyle(color: Colors.white, fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }
}
