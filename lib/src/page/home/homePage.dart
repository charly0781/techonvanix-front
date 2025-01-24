import 'package:flutter/material.dart';
import 'package:techonvanix/src/page/home/ContentHome.dart';
import '../../process/dto/GlobalData.dart';
import 'FloatingMenu.dart';
import 'HeaderHomePage.dart';
import 'MenuBarHeader.dart';
import 'FooterHomePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {
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
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2),
                BlendMode.dstATop,
              ),
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