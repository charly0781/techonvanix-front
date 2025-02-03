import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../dto/mail/SendMailDto.dart';

class RightColumn extends StatelessWidget {

  final SendMailDto sendMail;
  final String html;

  RightColumn({
    required this.sendMail,
    required this.html
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Html(
                data: html,
                style: {
                  "html": Style(
                    fontSize: FontSize(16), // Ajustar tamaño de texto
                  ),
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print("Send action triggered");
            },
            child: Text("Enviar"),
          ),
        ],
      ),
    );
  }
}
