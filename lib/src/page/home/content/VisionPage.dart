import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VisionPage extends StatelessWidget {

  final List<Map<String, dynamic>> menu;
  late final Map<String, dynamic>? visionPage;
  VisionPage({required this.menu}) {
    visionPage = menu.firstWhere(
          (data) =>
      data['active'] == true &&
          data['tipo'] == 'H' &&
          data['title'].toString() == 'Vision',
      orElse: () => {"title": "Vision", "content": "", "legend": "legend"},
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(screenWidth > 670 ? 40 : 20,
          screenWidth > 670 ? 60 : 20 ,
          screenWidth > 670 ? 150 : 30,
          0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              visionPage!['legend'].toString(),
              style: GoogleFonts.poppins(
                fontSize: screenWidth > 670 ? 34 : 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigoAccent,
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: screenWidth > 670 ? 50 : 25),
              Expanded(
                child: Text(
                  utf8.decode((visionPage!['content'] as String).runes.toList()),
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: screenWidth > 670 ? 20 : 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}