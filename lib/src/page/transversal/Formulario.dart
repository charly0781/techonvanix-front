import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TablaSeleccionDialog extends StatefulWidget {
  @override
  _TablaSeleccionDialogState createState() => _TablaSeleccionDialogState();
}

class _TablaSeleccionDialogState extends State<TablaSeleccionDialog> {
  final List<Map<String, String>> datos = [
    {"Nombre": "Juan Pedrito Perez guatamaya", "Correo": "juan@correo.com"},
    {"Nombre": "Ana", "Correo": "ana@correo.com"},
    {"Nombre": "Luis", "Correo": "luis@correo.com"},
    {"Nombre": "Maria", "Correo": "maria@correo.com"},
  ];

  List<Map<String, String>> seleccionados = [];
  bool seleccionarTodos = false;

  void _toggleSelection(Map<String, String> data, bool isSelected) {
    setState(() {
      if (isSelected) {
        seleccionados.add(data);
      } else {
        seleccionados.remove(data);
      }
    });
  }

  void _toggleSelectAll(bool? value) {
    setState(() {
      seleccionarTodos = value ?? false;
      if (seleccionarTodos) {
        seleccionados = List.from(datos);
      } else {
        seleccionados.clear();
      }
    });
  }

  void _cerrarDialogo() {
    Navigator.of(context).pop(seleccionados); // Devolver datos seleccionados
  }

  void _cancelarDialogo() {
    Navigator.of(context).pop(); // Solo cerrar sin devolver datos
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Ajuste dinámico del tamaño del diálogo
    double width = screenWidth < 600 ? screenWidth * 0.9 : screenWidth * 0.3;
    double height = screenHeight * 0.6;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selecciona los datos:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: 20,
                    columns: [
                      DataColumn(
                        label: Row(
                          children: [
                            Checkbox(
                              value: seleccionarTodos,
                              onChanged: _toggleSelectAll,
                            ),
                            // Text("Check", style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      DataColumn(
                        label: Text("Nombre", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text("Correo", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                    rows: datos.map((data) {
                      bool isSelected = seleccionados.contains(data);
                      return DataRow(
                        cells: [
                          DataCell(
                            Checkbox(
                              value: isSelected,
                              onChanged: (bool? value) {
                                _toggleSelection(data, value ?? false);
                              },
                            ),
                          ),
                          DataCell(Text(data["Nombre"]!)),
                          DataCell(Text(data["Correo"]!)),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _cancelarDialogo,
                  child: Text("Cancelar", style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(
                  onPressed: _cerrarDialogo,
                  child: Text("Aceptar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
