import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RightColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                "<html><body><h1>Preview</h1></body></html>",
                style: TextStyle(fontSize: 16),
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