
import 'package:flutter/cupertino.dart';
import 'package:techonvanix/src/page/home/content/pageviewe/ContentAds.dart';

import 'EmailMarketingHome.dart';

class Content extends StatefulWidget {
  final List<Map<String, dynamic>> menu;
  const Content({Key? key, required this.menu}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  ContentAds(menu: widget.menu),
                  EmailMarketingApp(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}