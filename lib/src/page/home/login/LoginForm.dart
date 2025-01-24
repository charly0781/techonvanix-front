
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techonvanix/src/process/dto/GlobalData.dart';

import '../../../process/dto/ApiResponse.dart';
import '../../../service/Utilitarios.dart';
import '../../transversal/MessageDialog.dart';
import '../ShowTooltip.dart';

class LoginForm extends StatefulWidget {

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0x8B84A9F3),
            Color(0x8B46A1E7),
            Color(0x8B0266FC),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                "lib/src/img/manos.png",
                height: 40,
              ),
            ),
            Text(
              'Inicio de Sesión',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('¿Olvidaste tu contraseña?',
                  style: TextStyle(color: Colors.black),),
                ),
                TextButton(
                  onPressed: () {
                    print("Registrarse");
                  },
                  child: Text('Registrarse',
                    style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
            const SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    _validatePass(context, username, password);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white
                  ),
                  child: Text('Aceptar',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cierra el formulario
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70
                  ),
                  child: Text('Cancelar',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _validatePass(BuildContext parentContext, username, password) async {

    Map<String, String> replacements = {
      "userName": username,
      "passwd" : password
    };

    final ApiResponse response = await Utilitarios.realizarPeticion(
      tipoPeticion: "POST",
      codigo: "login",
      parametros: replacements,
    );

    if (response.code == 200 && response.body != null) {
      final data = response.body;
      GlobalData.token = data['token'].toString().replaceFirst("Bearer ", "") ?? "";
      ScaffoldMessenger.of(parentContext).showSnackBar(
          SnackBar(content: Text("Acceso garantizado...",style: TextStyle(fontSize: 14),)),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(parentContext).showSnackBar(
        SnackBar(content: Text(response.message,style: TextStyle(fontSize: 14),)),
      );

    }

  }
}
