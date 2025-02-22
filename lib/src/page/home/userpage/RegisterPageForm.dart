import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techonvanix/src/page/transversal/MessageDialog.dart';
import '../../../dto/library/ApiResponse.dart';
import '../../../dto/library/GlobalData.dart';
import '../../../service/EnumServicio.dart';
import '../../../service/Utilitarios.dart';
import 'RegistroUsuario.dart';

class RegisterPageForm extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}


class _RegisterPageState extends State<RegisterPageForm> {

  List<Map<String, Object>> tipoDoc = [];
  final _formKey = GlobalKey<FormState>();
  String? selectedType;
  String selectedTypeId = "";
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _nitController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _aliasController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? companyData = GlobalData.companyData;
    bool isMobile = MediaQuery.of(context).size.width < 700;

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
                        child: Image.asset('lib/src/img/logoSF.png', height: 200),
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
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            child: DropdownButton<String>(
                                              hint: Text("Identificación"),
                                              value: selectedType,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedType = value;
                                                  selectedTypeId  = tipoDoc.firstWhere(
                                                        (type) => type['codigo'].toString() == value,
                                                    orElse: () => {"id": "0", "codigo": "Sin Datos"},
                                                  )['codigo'].toString();
                                                  _tipoController.text = selectedTypeId;
                                                });
                                              },
                                              items: tipoDoc.map((type) {
                                                return DropdownMenuItem<String>(
                                                  value: type['codigo'].toString(),
                                                  child: Text(type['nombre'].toString()),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          if (!isMobile)
                                            Expanded(child: _buildIntField('NIT', Icons.badge, _nitController)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          if (isMobile)
                                          Expanded(child: _buildIntField('NIT', Icons.badge, _nitController)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(child: _buildTextField('Correo', Icons.email, TextInputType.emailAddress, _emailController)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(child: _buildTextField('Nombre', Icons.person, TextInputType.text, _nombreController)),
                                          SizedBox(width: 10),
                                          Expanded(child: _buildTextField('Apellido', Icons.person_outline, TextInputType.text, _apellidoController)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(child: _buildIntField('WhatsApp', Icons.whatshot, _whatsappController)),
                                          SizedBox(width: 10),
                                          Expanded(child: _buildIntField('Celular', Icons.phone_android, _celularController)),
                                        ],
                                      ),
                                      _buildTextField('Alias Empresa', Icons.business, TextInputType.text, _aliasController),
                                      _buildDateField('Fecha de Nacimiento', Icons.cake),
                                      _buildTextField('Direccion', Icons.business, TextInputType.text, _direccionController),
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
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final datos = _obtenerDatosFormulario();
                                      final registro = RegistroUsuario(datos);

                                      ApiResponse response = await registro.registrarUsuario();

                                      if (response.code == 200) {
                                        String message = 'Usuario registrado con éxito \nrevise su correo para activar su cuenta';
                                        MessageDialog.handleMessage(
                                          context: context,
                                          title: "Éxito",
                                          message: message,
                                          confirmButtonText: "Aceptar",
                                          onConfirm: () {
                                            Navigator.of(context).pop(); // Cierra el diálogo si es necesario
                                          },
                                        );
                                      } else {
                                        MessageDialog.handleApiResponse(context, response);
                                      }
                                        ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(response.message)),
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

  Widget _buildTextField(String label, IconData icon, TextInputType keyboardType, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
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
          if (value.length > 100) {
            return 'Máximo 10 dígitos permitidos';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildIntField(String label, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Solo permite números
          LengthLimitingTextInputFormatter(10), // Máximo 10 caracteres
        ],
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
          if (value.length > 11) {
            return 'Máximo 10 dígitos permitidos';
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio';
          }
          if (value.length < 8 || value.length > 16) {
            return 'La contraseña debe tener entre 8 y 16 caracteres';
          }

          /*if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*]).{8,16}$').hasMatch(value)) {
            return 'Debe contener una mayúscula, un número y un carácter especial (!@#\$%^&*)';
          }*/
          return null;
        },
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

  Map<String, dynamic> _obtenerDatosFormulario() {
    return {
      "nit": _nitController.text,
      "tipoDocumento":  _tipoController.text,
      "email": _emailController.text,
      "nombre": _nombreController.text,
      "apellido": _apellidoController.text,
      "whatsapp": int.tryParse(_whatsappController.text) ?? 0,
      "celular": int.tryParse(_celularController.text) ?? 0,
      "alias": _aliasController.text,
      "direccion": _direccionController.text,
      "fechaNacimiento": _dateController.text,
      "password": _passwordController.text,
    };
  }

  @override
  void initState() {
    _getEstado('TC_TIPO_DOC', 'getTipoCategoria');
  }

  void _getEstado(String codigo, String endpoint) async {
    Map<String, String> replacements = {"codigo": codigo};
    final ApiResponse response = await Utilitarios.realizarPeticion(
      tipoPeticion: EnumParam.GET.value,
      codigo: endpoint,
      parametros: replacements,
    );
    if (tipoDoc.isEmpty) {
      if (response.code == 200 && response.body != null) {
        String codigo = response.body[0]["codigo"];
        replacements = {"code": codigo};
        Utilitarios.realizarPeticion(
            tipoPeticion: EnumParam.GET.value,
            codigo: "getTypoByCat",
            parametros: replacements,
            token: GlobalData.token)
            .then((response) {
          if (response.code == 200 && response.body != null) {
            setState(() {
              tipoDoc.clear();
              for (Map<String, dynamic> data in response.body) {
                tipoDoc.add(
                    data.map((key, value) => MapEntry(key, value as Object)));
              }
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(response.message)));
            return ApiResponse(
              code: response.code,
              message: response.message,
              body: null,
            );
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message)));
      }
    }
  }


}
