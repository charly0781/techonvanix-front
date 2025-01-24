
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Userpage extends StatefulWidget {
  @override
  _UserpageState createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  bool isLeftColumnVisible = true;
  List<String> types = ["Type 1", "Type 2", "Type 3"];
  List<String> templates = [];
  Map<String, List<String>> typeTemplates = {
    "Type 1": ["Template 1.1", "Template 1.2"],
    "Type 2": ["Template 2.1", "Template 2.2"],
    "Type 3": ["Template 3.1", "Template 3.2"],
  };
  List<String> fields = [];
  String? selectedType;
  String? selectedTemplate;
  String htmlPreview = "<html><body><h1>Preview</h1></body></html>";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dynamic Page Example"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle menu actions
              print(value);
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(value: "create_users", child: Text("Crear Usuarios Correo")),
              PopupMenuItem(value: "modify_users", child: Text("Modificar Correos")),
              PopupMenuItem(value: "delete_users", child: Text("Eliminar Correos")),
              PopupMenuItem(value: "list_clients", child: Text("Listar Mis Clientes")),
              PopupMenuItem(value: "my_account", child: Text("Mi Cuenta")),
              PopupMenuItem(value: "modify_data", child: Text("Modificar Mis Datos")),
              PopupMenuItem(value: "logout", child: Text("Logout")),
            ],
          ),
        ],
      ),
      body: Row(
        children: [
          if (isLeftColumnVisible) ...[
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLeftColumnVisible = false;
                      });
                    },
                    child: Text("Hide Column"),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        DropdownButton<String>(
                          hint: Text("Select Type"),
                          value: selectedType,
                          onChanged: (value) {
                            setState(() {
                              selectedType = value;
                              templates = typeTemplates[value!] ?? [];
                              selectedTemplate = null;
                              fields = [];
                            });
                          },
                          items: types.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                        ),
                        if (templates.isNotEmpty)
                          DropdownButton<String>(
                            hint: Text("Select Template"),
                            value: selectedTemplate,
                            onChanged: (value) {
                              setState(() {
                                selectedTemplate = value;
                                // Simulate fetching fields from a service
                                fields = List.generate(5, (index) => "Field ${index + 1}");
                              });
                            },
                            items: templates.map((template) {
                              return DropdownMenuItem(
                                value: template,
                                child: Text(template),
                              );
                            }).toList(),
                          ),
                        if (fields.isNotEmpty)
                          Expanded(
                            child: ListView.builder(
                              itemCount: fields.length,
                              itemBuilder: (context, index) {
                                return TextField(
                                  decoration: InputDecoration(
                                    labelText: fields[index],
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        htmlPreview = "<html><body><h1>Preview for $selectedTemplate</h1></body></html>";
                      });
                    },
                    child: Text("Preview"),
                  ),
                ],
              ),
            ),
          ],
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLeftColumnVisible = true;
                    });
                  },
                  child: Text("Show Column"),
                ),
                Expanded(
                  child: Container(
                    color: Colors.grey[200],
                    child: SingleChildScrollView(
                      child: Text(
                        htmlPreview,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle send action
                    print("Send action triggered");
                  },
                  child: Text("Enviar"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}