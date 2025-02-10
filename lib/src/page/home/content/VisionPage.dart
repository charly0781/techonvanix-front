import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../transversal/DynamicImageLoader.dart';

class VisionPage extends StatelessWidget {

  final List<Map<String, dynamic>> menu;
  late final Map<String, dynamic>? visionPage;
  VisionPage({required this.menu}) {
    visionPage = menu.firstWhere(
          (data) =>
      data['active'] == true &&
          data['tipo'] == 'H' &&
          data['title'].toString() == 'Vision',
      orElse: () => {"title": "", "content": "", "legend": "", "urlImage" : ""},
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        screenWidth > 670 ? 60 : 20,
        40,
        screenWidth > 670 ? 90 : 20,
        0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (screenWidth > 670)
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: DynamicImageLoader(
                    placeholderPath: 'lib/src/img/vision.png',
                    imageUrl: visionPage?["urlImage"] ?? '',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
          SizedBox(width: 20),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    visionPage!['legend'].toString(),
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth > 670 ? 30 : 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  utf8.decode((visionPage?['content'] as String).runes.toList()),
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: screenWidth > 670 ? 20 : 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}