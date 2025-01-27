import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techonvanix/src/process/dto/GlobalData.dart';
import 'package:techonvanix/src/service/EnumServicio.dart';
import '../../../process/dto/ApiResponse.dart';
import '../../../service/Utilitarios.dart';

class LeftColumn extends StatefulWidget {
  @override
  _LeftColumnState createState() => _LeftColumnState();
}

class _LeftColumnState extends State<LeftColumn> {
  bool isExpanded = true;
  final ScrollController _scrollController = ScrollController();
  List<Map<String, Object>> types =
    [{"id": 0,
      "nombre": "Sin Datos",
      "codigo" : "TL_DATO"}];
  final Map<String, TextEditingController> _controllers = {};
  List<Map<String, Object>> templates = [];
  Map<String, Object> template = {};
  String? selectedType;
  String? selectedTemplate;
  List<String> fields = [];


  @override
  void initState() {
    super.initState();
    _loadTypes();
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _loadTypes() {
    Map<String, String> replacements = {"codigo": "TC_PLANTILLA"};
    Utilitarios.realizarPeticion(tipoPeticion: EnumParam.GET.value,
        codigo: "getTipoCategoria", parametros: replacements,
        token: GlobalData.token).then((respuesta) {
      if (respuesta.code == 200 && respuesta.body != null) {

        String codigo = respuesta.body[0]["codigo"];
        replacements = {"code": codigo};

        // Llamar a otro servicio si es necesario
        Utilitarios.realizarPeticion(tipoPeticion: EnumParam.GET.value,
            codigo: "getTypoByCat",
            parametros: replacements,
            token: GlobalData.token).then((response) {
          if (response.code == 200 && response.body != null) {
            setState(() {
              types.clear();
              for (Map<String, dynamic> data in response.body) {
                types.add(data.map((key, value) => MapEntry(key, value as Object)));
              }
            });
          } else {
            _showErrorSnackbar(response.message);
            return ApiResponse(
              code: response.code,
              message: response.message,
              body: null,
            );
          }
        });

      } else {
        _showErrorSnackbar(respuesta.message);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: isExpanded ? 250 : 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF84A9F3),
            Color(0xFF46A1E7),
            Color(0xFF0266FC),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(isExpanded ? Icons.arrow_back : Icons.arrow_forward),
            color: Colors.white,
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
          if (isExpanded) ...[
            DropdownButton<String>(
              hint: Text("Select Type"),
              value: selectedType,
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                  templates = [];
                  selectedTemplate = null;
                });
                int selectedTypeId = types
                    .firstWhere(
                      (type) => type['id'].toString() == value,
                  orElse: () =>
                  {"id": 0, "nombre": "Sin Datos", "codigo": "TL_DATO"},
                )['id'] as int;
                _loadTemplates(selectedTypeId);
              },
              items: types.map((type) {
                return DropdownMenuItem<String>(
                  value: type['id'].toString(),
                  child: Text(type['nombre'].toString()),
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
                    fields = getDataReplace(value);
                  });
                },
                items: templates.map((template) {
                  return DropdownMenuItem<String>(
                    value: template['id'].toString(),
                    child: Text(
                      template['titulo'].toString().substring(
                        0,
                        template['titulo'].toString().length > 28
                            ? 28
                            : template['titulo'].toString().length,
                      ),
                    ),
                  );
                }).toList(),
              ),
            if (fields.isNotEmpty)
              Expanded(
                child: Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: fields.map((field) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextField(
                                controller: _controllers.putIfAbsent(field, () => TextEditingController()),
                                decoration: InputDecoration(
                                  labelText: field,
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue, // Resaltar el borde
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: () {
                // Obtener los valores ingresados en cada campo
                Map<String, String> userValues = {};
                for (String field in fields) {
                  userValues[field] = _controllers[field]?.text ?? "";
                }

                String html = utf8.decode((template["formatoHtml"] as String).runes.toList());

                userValues.forEach((key, value) {
                  html = html.replaceAll("[$key]", value.isNotEmpty ? value : "");
                });
                List<int> utf8Bytes = utf8.encode(html);
                String utf8Html = utf8.decode(utf8Bytes);
                print(utf8Html);
              },
              child: Text("Preview"),
            ),
          ],
        ],
      ),
    );
  }


  void _loadTemplates(int typeId) {
    Map<String, String> replacements = {"idType": typeId.toString()};
    Utilitarios.realizarPeticion(
      tipoPeticion: EnumParam.GET.value,
      codigo: "getTemplatebyType",
      parametros: replacements,
      token: GlobalData.token,
    ).then((response) {
      if (response.code == 200 && response.body != null) {
        setState(() {
          templates.clear();
          for (Map<String, dynamic> data in response.body) {
            templates.add(data.map((key, value) => MapEntry(key, value ?? '')));
          }
        });
      } else {
        _showErrorSnackbar(response.message);
        setState(() {
          templates.clear();
          templates = [{"id": 0,
            "titulo": "Sin Datos",
            "codigo" : "TL_DATO",
            "replaceData": ""}];
        });
      }
    });
  }

  List<String> getDataReplace(String? value) {

    template.clear;

    template = templates
        .firstWhere(
            (x) => x["id"].toString() == value.toString());

    String dataReplace = templates
        .firstWhere(
          (x) => x["id"].toString() == value.toString(),
      orElse: () => {
        "replaceData": "",
      },
    )['replaceData'] as String? ?? "";

    fields.clear();
    return dataReplace.isNotEmpty ? dataReplace.split(",") : [];
  }
  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

}