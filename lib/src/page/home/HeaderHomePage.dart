import 'package:flutter/material.dart';
import 'package:techonvanix/src/page/home/login/LoginForm.dart';
import 'package:techonvanix/src/page/home/userpage/RegisterPageForm.dart';
import '../../process/dto/GlobalData.dart';
import '../transversal/DynamicImageLoader.dart';


class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final Map<String, dynamic>? companyData = GlobalData.companyData;

    return screenWidth > 670
        ? _buildDesktopHeader(context, companyData)
        : _buildMobileHeader(context, companyData);
  }

  // Header para dispositivos de escritorio
  Widget _buildDesktopHeader(BuildContext context, Map<String, dynamic>? companyData) {
    return Container(
      color: Colors.blue[800],
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Uso de DynamicImageLoader
              DynamicImageLoader(
                placeholderPath: 'lib/src/img/logoSF.png',
                imageUrl: companyData?['urlLogo']?.toString(),
                width: 160,
                height: 60,
              ),
              const SizedBox(width: 5),
              const Text(
                '',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          Row(
            children: [
              ..._buildMenuItems(context),
              _buildLoginItem(context),
            ],
          ),
        ],
      ),
    );
  }

  // Header para dispositivos móviles
  Widget _buildMobileHeader(BuildContext context, Map<String, dynamic>? companyData) {
    return AppBar(
      backgroundColor: Colors.blue[800],
      title: Row(
        children: [
          // Uso de DynamicImageLoader
          DynamicImageLoader(
            placeholderPath: 'lib/src/img/logoSF.png',
            imageUrl: companyData?['urlLogo']?.toString(),
            width: 120,
            height: 40,
          ),
          const SizedBox(width: 10),
          const Text(' ', style: TextStyle(fontSize: 16, color: Colors.white)),
        ],
      ),
      actions: [
        Align(
          alignment: Alignment.centerRight,
          child: _buildLoginItem(context),
        ),
      ],
    );
  }

  // Método para construir los elementos del menú
  List<Widget> _buildMenuItems(BuildContext context) {
    List<String> menuItems = ['Precios', 'Empresa', 'Herramientas'];
    return menuItems.map((item) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          item,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }).toList();
  }


  Widget _buildLoginItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              _onLoginClick(context);
            },
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPageForm()),
              );
            },
            child: const Text(
              'Registro',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }


  void _onLoginClick(BuildContext context) {
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
    );
    // MessageDialog.showMessage(
    //   context,
    //   title: "Informacion",
    //   message: "Proyecto en construccion...",
    //   confirmButtonText: "Ok",
    //   onConfirm: () {
    //     Navigator.of(context).pop(); // Cierra el diálogo
    //     print("Botón Sí presionado");
    //   },
    //   onCancel: () {
    //     Navigator.of(context).pop(); // Cierra el diálogo
    //     print("Botón No presionado");
    //   },
    // );
  }
}
