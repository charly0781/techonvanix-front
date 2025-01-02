import 'package:flutter/material.dart';
import 'package:techonvanix/src/page/home/ContentHome.dart';
import '../../process/dto/GlobalData.dart';
import 'FloatingMenu.dart';
import 'HeaderHomePage.dart';
import 'MenuBarHeader.dart';
import 'FooterHomePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? companyData = GlobalData.companyData;
    final List<dynamic>? allUrls = GlobalData.allUrls;

    return Scaffold(
      drawer: const Drawer(
        child: MenuBarHeader(),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.1),
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
          Column(
            children: [
              const HeaderHomePage(),
              // Aquí se carga el ContentHome
              Expanded(
                child: ContentHome(),
              ),
              const FooterHomePage(),
            ],
          ),
        ],
      ),
      floatingActionButton: const FloatingMenu(),
    );
  }
}