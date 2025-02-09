
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_html/flutter_html.dart';

class Planespage extends StatelessWidget {

  final List<Map<String, dynamic>> menu;
  late final Map<String, dynamic>? dataPage;
  Planespage({required this.menu}) {
    dataPage = menu.firstWhere(
          (data) =>
      data['active'] == true &&
          data['tipo'] == 'H' &&
          data['title'].toString() == 'Planes',
      orElse: () => {"title": "Planes", "content": "", "legend": "Planes"},
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(screenWidth > 670 ? 90 : 20,
          screenWidth > 670 ? 40 : 40 ,
          screenWidth > 670 ? 90 : 20,
          0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              dataPage!['legend'].toString(),
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
                child: Html(
                  data: utf8.decode(
                    (dataPage!['content'] as String).runes.toList(),
                    allowMalformed: true,
                  ),
                  style: {
                    "html": Style(
                      fontSize: FontSize(screenWidth > 670
                          ? 20
                          : 14,),
                      fontFamily: 'monospace',
                    ),
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}