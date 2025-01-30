


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techonvanix/src/service/EnumServicio.dart';
import 'package:techonvanix/src/service/Utilitarios.dart';

import '../../process/dto/GlobalData.dart';

class AccountActivationPage extends StatefulWidget {

  final String encryptedData;
  final String urlConfirmacion = "urlConfirmacion";

  AccountActivationPage({
    required String this.encryptedData,
  });

  @override
  _AccountActivationPageState createState() => _AccountActivationPageState();
}

class _AccountActivationPageState extends State<AccountActivationPage> {
  String? accountName;
  Map<String, Object> account = {};
  bool isLoading = true;
  bool activationSuccess = false;
  int code = 0;
  String errorMensaje = "";
  @override
  void initState() {
    super.initState();
    _activateAccount();
    isLoading = false;
  }

  Future<void> _activateAccount() async {
    try {
      Map<String, String> replacements = {"mail": widget.encryptedData};

      Utilitarios.realizarPeticion(tipoPeticion: EnumParam.GET.value,
          codigo: "urlConfirmacion",
          parametros: replacements,
          token: GlobalData.token).then((response) {

          setState(() {
            activationSuccess = false;
            code = response.code;
            if (code == 200 && response.body != null) {
              print(response.body);
              account = response.body;
              activationSuccess = true;
            } else {
              errorMensaje = response.message.toString();
              activationSuccess = false;
            }
          });
      });

    } catch (e) {
      setState(() {
        activationSuccess = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? companyData = GlobalData.companyData;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2),
                BlendMode.dstATop,
              ),
              child: Image.network(
                companyData?['urlFondo']?.toString() ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'lib/src/img/fondo.jpg',// Imagen local de respaldo
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          // Contenido principal
          Center(
            child: isLoading
                ? CircularProgressIndicator()
                : activationSuccess
                ? _buildSuccessContent()
                : _buildErrorContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle, color: Colors.green, size: 80),
        SizedBox(height: 20),
        Text(
          '¡Activación exitosa!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Bienvenido, $account[''nombre''] $account[''apellido'']',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildErrorContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error, color: Colors.red, size: 80),
        SizedBox(height: 20),
        Text(
          'Error al activar la cuenta',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          errorMensaje + (code == 200038
              ? '\nPor favor solicita uno nuevo haciendo click aquí.'
              : '\nPor favor, intenta nuevamente más tarde.'),
          style: TextStyle(fontSize: 18),
        ),
        if (code == 200038)
          GestureDetector(
            onTap: () {
              _handleRequestNewAccount();
            },
            child: Text(
              'Hacer clic aquí',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
      ],
    );
  }

// Método que se llama al hacer clic
  void _handleRequestNewAccount() {
    // Aquí implementas la lógica para generar el enlace o realizar la acción que desees.
    print('Solicitar nuevo enlace o realizar alguna acción');
    // Puedes retornar el mensaje o el enlace aquí según la lógica que necesites.
  }

}
