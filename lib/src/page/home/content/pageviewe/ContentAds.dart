import 'dart:async';
import 'package:flutter/material.dart';

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
      ads = widget.menu.where(
              (data) => data['isActive'] == true && data['tipo'] == 'L'
      ).toList();
      print("ads: $ads " + ads.toString());

    }
    _startAutoScroll();
  }

  @override
  void didUpdateWidget(covariant ContentAds oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.menu != widget.menu && widget.menu.isNotEmpty) {
      setState(() {
        ads = widget.menu.where(
                (data) => data['tipo'].toString() == 'L'
        ).toList();
      });
    }
  }

  void _startAutoScroll() {
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
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
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ad['title']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    ad['description']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
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
          margin: EdgeInsets.symmetric(horizontal: 4),
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
}