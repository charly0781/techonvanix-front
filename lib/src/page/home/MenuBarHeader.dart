import 'package:flutter/material.dart';


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

  IconData _getIconFromHex(String hex) {
    try {
      int hexValue = int.parse(hex, radix: 16);  // Intentar convertir a entero
      return IconData(hexValue, fontFamily: 'MaterialIcons');
    } catch (e) {
      print('Error al convertir el hexadecimal: $hex');
      return Icons.error; // Devuelve un ícono por defecto si hay un error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.drawerList.map((menu) {
        return ListTile(
          leading: menu['urlImage'] != null
              ? Icon(
            _getIconFromHex(menu['urlImage']),
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
