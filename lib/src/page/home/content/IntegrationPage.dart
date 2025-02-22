
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../transversal/CustomData.dart';

class IntegrationPage extends StatelessWidget {

  final List<Map<String, dynamic>> menu;
  late final Map<String, dynamic>? integration;
  IntegrationPage({required this.menu}) {
    integration = menu.firstWhere(
          (data) =>
      data['id'] == 'integracion',
      orElse: () => {"title": "Integracion", "content": "", "legend": "Integracion"},
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
              integration!['legend']['value'].toString(),
              style: CustomData.getFontFromName(integration!['legend']['font'],
                  integration!['legend']['fontSize'],
                  integration!['legend']['fontColor'],
                  true),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: screenWidth > 670 ? 50 : 25),
              Expanded(
                child: Html(
                  data: utf8.decode(
                    (integration!['content']['value'] as String).runes.toList(),
                    allowMalformed: true,
                  ),
                  style: {
                    "html": Style(
                      fontSize: FontSize(screenWidth > 670
                          ? 18
                          : 16,),
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