
import 'package:flutter/material.dart';
import 'package:techonvanix/src/page/dinamicPage/NotFoundPage.dart';
import 'package:techonvanix/src/page/home/userpage/RegisterPageForm.dart';
import '../home/login/LoginForm.dart';

class PageSelector extends StatefulWidget {
  final Map<String, dynamic> drawerItem;
  final VoidCallback onClose;  // Recibimos función para restaurar la página anterior

  const PageSelector({
    Key? key,
    required this.drawerItem,
    required this.onClose,
  }) : super(key: key);

  @override
  _PageSelectorState createState() => _PageSelectorState();
}

class _PageSelectorState extends State<PageSelector> {
  @override
  void initState() {
    super.initState();
    _selectPage();
  }

  void _selectPage() {
    final String className = widget.drawerItem['className'] ?? '';

    switch (className) {
      case 'login':
        Future.delayed(Duration.zero, () {
          _buildLoginPage(context);
        });
        break;
      case 'register':
        Future.delayed(Duration.zero, () {
          _navigateToPage(RegisterPageForm());
        });
        break;
      default:
        Future.delayed(Duration.zero, () {
          _navigateToPage(NotFoundPage());
        });
    }
  }

  void _buildLoginPage(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            width: 240,
            padding: const EdgeInsets.all(20.0),
            child: LoginForm(),
          ),
        );
      },
    ).then((_) {
      widget.onClose();  // Llamamos a la función para restaurar la pantalla
    });
  }

  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    ).then((_) {
      widget.onClose();  // Restauramos la pantalla al regresar
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();  // No devuelve nada porque las páginas ya manejan la navegación
  }
}
