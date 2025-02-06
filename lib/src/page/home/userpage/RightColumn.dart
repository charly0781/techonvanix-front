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
        padding: EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sendMail.subject,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'From: ' + sendMail.sender,
                        style: TextStyle(fontSize: 14,  fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'To: ',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
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

