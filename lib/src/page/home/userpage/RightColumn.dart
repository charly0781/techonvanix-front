import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class RightColumn extends StatelessWidget {
  final String htmlContent;

  RightColumn({required this.htmlContent});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Html(
                data: htmlContent, // Mostrar el HTML recibido
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
