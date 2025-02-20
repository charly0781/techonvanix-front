import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:techonvanix/src/page/transversal/CustomData.dart';

import '../../../transversal/DynamicImageLoader.dart';

class ContentAds extends StatefulWidget {

  final List<Map<String, dynamic>> menu;
  const ContentAds({Key? key, required this.menu}) : super(key: key);

  @override
  _ContentAdsState createState() => _ContentAdsState();
}

class _ContentAdsState extends State<ContentAds> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  late List<Map<String, dynamic>> ads = [];

  @override
  void initState() {
    super.initState();
    print ("menu ads "+ widget.menu.toString());
    if (widget.menu.isNotEmpty) {
      List<Map<String, dynamic>> temp  = _getMenu('adds');
      ads = temp
          .where((item) => item.containsKey('menu') && item['menu'] is List) // Validar 'menu'
          .expand((item) => (item['menu'] as List)
          .whereType<Map<String, dynamic>>() // Filtrar solo mapas dentro de 'menu'
          .where((element) =>
      element.containsKey('active') && // Evitar errores si falta la clave
          element.containsKey('tipo') &&
          element['active'] == true &&
          element['tipo'] == 'L'))
          .toList();
    }
    _startAutoScroll();
  }

  @override
  void didUpdateWidget(covariant ContentAds oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.menu != widget.menu && widget.menu.isNotEmpty) {
      setState(() {
        List<Map<String, dynamic>> temp  = _getMenu('adds');
        ads = temp
              .where((item) => item.containsKey('menu') && item['menu'] is List) // Validar 'menu'
              .expand((item) => (item['menu'] as List)
              .whereType<Map<String, dynamic>>() // Filtrar solo mapas dentro de 'menu'
              .where((element) =>
          element.containsKey('active') && // Evitar errores si falta la clave
              element.containsKey('tipo') &&
              element['active'] == true &&
              element['tipo'] == 'L'))
              .toList();
      });
    }
  }

  void _startAutoScroll() {
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentIndex < ads.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (ads.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        SizedBox(
          height: screenWidth > 400 ? 200 : 120,
          child: PageView.builder(
            controller: _pageController,
            itemCount: ads.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              return _buildAd(ads[index]);
            },
          ),
        ),
        SizedBox(height: 10),
        _buildIndicators(),
      ],
    );
  }

  Widget _buildAd(Map<String, dynamic> ad) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      elevation: 4,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: DynamicImageLoader(
                placeholderPath: 'lib/src/img/fondo.png',
                imageUrl: ad["urlImage"] ?? '',
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          // Contenedor para los textos con margen
          Positioned(
            top: 20, // margen superior de 20 píxeles
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  utf8.decode((ad['legend']['value'] as String).runes.toList()),
                  textAlign: TextAlign.left,
                  style: CustomData.getFontFromName(ad['legend']['font'],
                      ad['legend']['fontSize'],
                      ad['legend']['fontColor'])
                ),
                SizedBox(height: 20), // espacio entre legend y description
                Text(
                  utf8.decode((ad['description']['value'] as String).runes.toList()),
                  textAlign: TextAlign.left,
                  style: CustomData.getFontFromName(ad['description']['font'],
                    ad['description']['fontSize'],
                    ad['description']['fontColor']),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(ads.length, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 3),
          width: _currentIndex == index ? 12 : 8,
          height: _currentIndex == index ? 12 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index ? Colors.blue : Colors.grey,
          ),
        );
      }),
    );
  }

  List<Map<String, dynamic>> _getMenu(String codigo) {
    List<Map<String, dynamic>> temp = ( widget.menu as List?)?.whereType<Map<String, dynamic>>()
        .where((element) => element['id'] == codigo)
        .toList() ?? [];
    return temp;
  }
  
}