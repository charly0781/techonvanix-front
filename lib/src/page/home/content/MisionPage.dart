import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MisionPage extends StatelessWidget {

  final List<Map<String, dynamic>> menu;
  late final Map<String, dynamic>? misionPage;
  MisionPage({required this.menu}) {
    misionPage = menu.firstWhere(
          (data) =>
      data['active'] == true &&
          data['tipo'] == 'H' &&
          data['title'].toString() == 'Mision',
      orElse: () => {"title": "Mision", "content": "", "legend": "legend"},
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(screenWidth > 670 ? 90 : 20,
          40, screenWidth > 670 ? 90 : 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            misionPage!['legend'].toString(),
            style: GoogleFonts.poppins(
              fontSize: screenWidth > 670 ? 34 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.indigoAccent,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: screenWidth > 670 ? 50 : 25),
              Expanded(
                child: Text(
                  utf8.decode((misionPage!['content'] as String).runes.toList()),
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