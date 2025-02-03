import 'package:flutter/material.dart';
import 'package:techonvanix/src/page/transversal/CustomIcons.dart';


class MenuBarHeader extends StatefulWidget {
  final List<Map<String, dynamic>> drawerList;
  final Function(Map<String, dynamic>) onMenuItemSelected;

  const MenuBarHeader({
    Key? key,
    required this.drawerList,
    required this.onMenuItemSelected,
  }) : super(key: key);

  @override
  _MenuBarHeaderState createState() => _MenuBarHeaderState();
}

class _MenuBarHeaderState extends State<MenuBarHeader> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.drawerList.map((menu) {
        return ListTile(

          leading: menu['urlImage'] != null
              ? Icon(
            CustomIcons.getIconFromName(menu['urlImage']),
            size: 24,
            color: Colors.blue,
          )
              : const Icon(Icons.error, color: Colors.blue),
          title: Text(menu['title'] ?? ''),
          onTap: () {
            widget.onMenuItemSelected(menu);
            Navigator.pop(context);
          },
        );
      }).toList(),
    );
  }
}

