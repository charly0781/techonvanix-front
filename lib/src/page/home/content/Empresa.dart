
import 'package:flutter/cupertino.dart';
import 'IntegrationPage.dart';
import 'MisionPage.dart';
import 'PlanesPage.dart';
import 'VisionPage.dart';

class Empresa extends StatelessWidget {

  final List<Map<String, dynamic>> menu;
  Empresa({required this.menu});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              children: [
                MisionPage(menu: menu),
                VisionPage(menu: menu),
                IntegrationPage(menu: menu),
                PlanesPage(menu: menu)
              ],
            ),
          ),
        );
      },
    );
  }
}