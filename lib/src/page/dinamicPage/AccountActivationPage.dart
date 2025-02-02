
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
  String errorMensaje = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      _activateAccount();
    });
  }

  Future<void> _activateAccount() async {
    try {
      Map<String, String> replacements = {"mail": widget.encryptedData};

      Utilitarios.realizarPeticion(tipoPeticion: EnumParam.GET.value,
          codigo: "urlConfirmacion",
          parametros: replacements,
          token: GlobalData.token).then((response) {

          activationSuccess = false;
        if (response.code == 200 && response.body != null) {
          print(response.body);
          account = response.body;
          activationSuccess = true;
        } else {
          errorMensaje = response.message.toString();
          activationSuccess = false;
          /*MessageDialog.showMessage(context, title: "Error",
              message: response.message, confirmButtonText: "Aceptar");
          Navigator.pop(context);
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );*/
        }
        isLoading = false;
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
          'Por favor, intenta nuevamente más tarde. \n' + errorMensaje,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
