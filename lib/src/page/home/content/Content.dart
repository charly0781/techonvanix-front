
import 'package:flutter/cupertino.dart';
import 'package:techonvanix/src/page/home/content/IntegrationPage.dart';
import 'package:techonvanix/src/page/home/content/MisionPage.dart';
import 'package:techonvanix/src/page/home/content/PlanesPage.dart';
import 'package:techonvanix/src/page/home/content/VisionPage.dart';

class Content extends StatelessWidget {

  final List<Map<String, dynamic>> menu;
  Content({required this.menu});

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
                // Planespage(menu: menu)

              ],
            ),
          ),
        );
      },
    );
  }
}