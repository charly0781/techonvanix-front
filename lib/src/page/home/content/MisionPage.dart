import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../transversal/DynamicImageLoader.dart';

class MisionPage extends StatelessWidget {

  final List<Map<String, dynamic>> menu;
  late final Map<String, dynamic>? misionPage;
  MisionPage({required this.menu}) {
    misionPage = menu.firstWhere(
          (data) =>
      data['active'] == true &&
          data['tipo'] == 'H' &&
          data['title'].toString() == 'Mision',
      orElse: () => {"title": "Mision", "content": "", "legend": "", "urlImage" : ""},
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        screenWidth > 670 ? 50 : 20,
        20,
        screenWidth > 670 ? 40 : 10,
        0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Primera columna: Contiene título y contenido en un Column
          Expanded(
            flex: 2, // La primera columna ocupa más espacio
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  misionPage!['legend'].toString(),
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth > 670 ? 30 : 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigoAccent,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  utf8.decode((misionPage?['content'] as String).runes.toList()),
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

          SizedBox(width: 20), // Espaciado entre columnas

          // Segunda columna: Imagen que se ajusta al tamaño de la primera columna
          if (screenWidth > 670)
            Expanded(
              flex: 1, // Ocupa menos espacio que la primera columna
              child: Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: DynamicImageLoader(
                    placeholderPath: 'lib/src/img/mision.png',
                    imageUrl: misionPage?["urlImage"] ?? '',
                    width: 250,
                    height: 250,
                  ),
                ),
              ),
            ),
        ],
      ),
    );

  }

}