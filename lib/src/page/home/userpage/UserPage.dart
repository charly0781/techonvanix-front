
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LeftColumn.dart';
import 'RightColumn.dart';


class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Management"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
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
          LeftColumn(),
          Expanded(
            flex: 4,
            child: RightColumn(),
          ),
        ],
      ),
    );
  }
}