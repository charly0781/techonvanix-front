
import 'package:flutter/cupertino.dart';
import 'package:techonvanix/src/page/home/content/pageviewe/ContentAds.dart';

class Content extends StatelessWidget {

  final List<Map<String, dynamic>> menu;
  Content({required this.menu});

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              children: [
                ContentAds(menu: menu),
              ],
            ),
          ),
        );
      },
    );
  }
}