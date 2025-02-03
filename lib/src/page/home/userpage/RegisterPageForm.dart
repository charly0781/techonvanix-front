import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dto/library/GlobalData.dart';

class RegisterPageForm extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}


class _RegisterPageState extends State<RegisterPageForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? companyData = GlobalData.companyData;
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.3),
                BlendMode.dstATop,
              ),
              child: Image.network(
                companyData?['urlFondo']?.toString() ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'lib/src/img/fondo.jpg',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isMobile)
                    Expanded(
                      child: Center(
                        child: Image.asset('lib/src/img/logoSF.png', height: 250),
                      ),
                    ),
                  Expanded(
                    child: Card(
                      elevation: 12,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      color: Colors.white.withOpacity(0.95),
                      shadowColor: Colors.deepPurpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('lib/src/img/logoSF.png', height: 50),
                            SizedBox(height: 10),
                            Text('Registro de Usuario',
                                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                            SizedBox(height: 20),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(child: _buildTextField('NIT', Icons.badge, TextInputType.number)),
                                          SizedBox(width: 10),
                                          Expanded(child: _buildTextField('Correo', Icons.email, TextInputType.emailAddress)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(child: _buildTextField('Nombre', Icons.person)),
                                          SizedBox(width: 10),
                                          Expanded(child: _buildTextField('Apellido', Icons.person_outline)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(child: _buildTextField('WhatsApp', Icons.whatshot, TextInputType.phone)),
                                          SizedBox(width: 10),
                                          Expanded(child: _buildTextField('Celular', Icons.phone_android, TextInputType.phone)),
                                        ],
                                      ),
                                      _buildTextField('Alias Empresa', Icons.business),
                                      _buildDateField('Fecha de Nacimiento', Icons.cake),
                                      Row(
                                        children: [
                                          Expanded(child: _buildPasswordField('Contraseña', Icons.lock, _passwordController)),
                                          SizedBox(width: 10),
                                          Expanded(child: _buildConfirmPasswordField('Confirmar Contraseña', Icons.lock_outline, _confirmPasswordController)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    backgroundColor: Colors.grey,
                                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancelar', style: TextStyle(fontSize: 18, color: Colors.white)),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    backgroundColor: Colors.deepPurple,
                                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Registro exitoso')),
                                      );
                                    }
                                  },
                                  child: Text('Registrar', style: TextStyle(fontSize: 18, color: Colors.white)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmPasswordField(String label, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        enableInteractiveSelection: false, // Bloquea copiar/pegar
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: Colors.deepPurple),
        ),
        validator: (value) {
          if (value != _passwordController.text) {
            return 'Las contraseñas no coinciden';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, [TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: Colors.deepPurple),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField(String label, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: Colors.deepPurple),
        ),
      ),
    );
  }

  Widget _buildDateField(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _dateController,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: Colors.deepPurple),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            setState(() {
              _dateController.text = "${pickedDate.day.toString().padLeft(2, '0')}/"
                  "${pickedDate.month.toString().padLeft(2, '0')}/"
                  "${pickedDate.year}";
            });
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Seleccione una fecha';
          }
          return null;
        },
      ),
    );
  }


}
