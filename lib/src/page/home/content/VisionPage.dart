import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../transversal/CustomData.dart';
import '../../transversal/DynamicImageLoader.dart';

class VisionPage extends StatelessWidget {

  final List<Map<String, dynamic>> menu;
  late final Map<String, dynamic>? visionPage;
  VisionPage({required this.menu}) {
    visionPage = menu.firstWhere(
          (data) =>
      data['id'] == 'vision' ,
      orElse: () => {"title": "", "content": "", "legend": "", "urlImage" : ""},
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        screenWidth > 670 ? 50 : 20,
        40,
        screenWidth > 670 ? 40 : 20,
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
                    width: 250,
                    height: 250,
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
                    visionPage!['legend']['value'].toString(),
                    style: CustomData.getFontFromName(visionPage!['legend']['font'],
                        visionPage!['legend']['fontSize'],
                        visionPage!['legend']['fontColor'],
                        true),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  utf8.decode((visionPage?['content']['value'] as String).runes.toList()),
                  textAlign: TextAlign.justify,
                  style: CustomData.getFontFromName(visionPage!['content']['font'],
                      visionPage!['content']['fontSize'],
                      visionPage!['content']['fontColor'],
                      false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}