import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../dto/mail/SendMailDto.dart';

class RightColumn extends StatelessWidget {
  final SendMailDto sendMail;
  final String html;

  RightColumn({required this.sendMail, required this.html});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sendMail.subject,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('From: ' + sendMail.sender,
                style: TextStyle(fontWeight: FontWeight.w500)),
            Text('To: ....', style: TextStyle(fontWeight: FontWeight.w500)),
            Divider(),
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Html(
                    data: html,
                    style: {
                      "html": Style(
                        fontSize: FontSize(16),
                      ),
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

