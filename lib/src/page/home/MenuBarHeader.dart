
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuBarHeader extends StatelessWidget {
  const MenuBarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Empresa'),
          onTap: () {
            Navigator.pop(context);  // Cerrar el drawer
          },
        ),
        ListTile(
          title: const Text('Precios'),
          onTap: () {
            Navigator.pop(context);  // Cerrar el drawer
          },
        ),
        ListTile(
          title: const Text('Herramientas'),
          onTap: () {
            Navigator.pop(context);  // Cerrar el drawer
          },
        ),
        ListTile(
          title: const Text('Contáctanos'),
          onTap: () {
            Navigator.pop(context);  // Cerrar el drawer
          },
        ),
      ],
    );
  }
}
