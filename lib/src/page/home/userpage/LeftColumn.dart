import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techonvanix/src/dto/mail/AdjuntosDto.dart';
import 'package:techonvanix/src/dto/mail/SendMailDto.dart';

import '../../../dto/library/ApiResponse.dart';
import '../../../dto/library/GlobalData.dart';
import '../../../service/EnumServicio.dart';
import '../../../service/Utilitarios.dart';


class LeftColumn extends StatefulWidget {
  final SendMailDto sendMail;
  final Function(String) onPreviewGenerated;

  LeftColumn({
    required this.sendMail,
    required this.onPreviewGenerated,
  });

  @override
  _LeftColumnState createState() => _LeftColumnState();
}

class _LeftColumnState extends State<LeftColumn> {
  bool isExpanded = true;
  List<AdjuntosDto> listaAdjuntos = [];
  String asunto = "";

  final ScrollController _scrollController = ScrollController();
  List<Map<String, Object>> types = [{"id": 0, "nombre": "Sin Datos", "codigo": "TL_DATO"}];
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
    _scrollController.dispose();
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _loadTypes() {
    Map<String, String> replacements = {"codigo": "TC_PLANTILLA"};
    Utilitarios.realizarPeticion(
        tipoPeticion: EnumParam.GET.value,
        codigo: "getTipoCategoria",
        parametros: replacements,
        token: GlobalData.token)
        .then((respuesta) {
      if (respuesta.code == 200 && respuesta.body != null) {
        String codigo = respuesta.body[0]["codigo"];
        replacements = {"code": codigo};

        Utilitarios.realizarPeticion(
            tipoPeticion: EnumParam.GET.value,
            codigo: "getTypoByCat",
            parametros: replacements,
            token: GlobalData.token)
            .then((response) {
          if (response.code == 200 && response.body != null) {
            setState(() {
              types.clear();
              for (Map<String, dynamic> data in response.body) {
                types.add(
                    data.map((key, value) => MapEntry(key, value as Object)));
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
          templates = [
            {
              "id": 0,
              "titulo": "Sin Datos",
              "codigo": "TL_DATO",
              "replaceData": ""
            }
          ];
        });
      }
    });
  }

  List<String> getDataReplace(String? value) {
    template.clear;
    template =
        templates.firstWhere((x) => x["id"].toString() == value.toString());

    String dataReplace = templates.firstWhere(
          (x) => x["id"].toString() == value.toString(),
      orElse: () => {
        "replaceData": "",
      },
    )['replaceData'] as String? ??
        "";

    fields.clear();
    return dataReplace.isNotEmpty ? dataReplace.split(",") : [];
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _seleccionarAdjuntos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        listaAdjuntos.addAll(result.files.map((file) {
          return AdjuntosDto(
            file: file.bytes != null ? base64Encode(file.bytes!) : '',
            formato: file.extension ?? "desconocido",
            nombre: file.name,
          );
        }).toList());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double expandedWidth = width > 600 ? 290 : 250;

    return AnimatedContainer(
      duration: Duration(milliseconds: 450),
      width: isExpanded ? expandedWidth : 20,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF84A9F3), Color(0xFF46A1E7), Color(0xFF0266FC)],
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
          if (isExpanded)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        hint: Text("Select Type"),
                        value: selectedType,
                        onChanged: (value) {
                          setState(() {
                            fields = [];
                            asunto = "";
                            selectedType = value;
                            templates = [];
                            selectedTemplate = null;
                            listaAdjuntos.clear();
                            _controllers.clear();
                          });
                          int selectedTypeId = types.firstWhere(
                                (type) => type['id'].toString() == value,
                            orElse: () => {"id": 0, "nombre": "Sin Datos"},
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
                    ),
                    if (templates.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<String>(
                          hint: Text("Select Template"),
                          value: selectedTemplate,
                          onChanged: (value) {
                            setState(() {
                              selectedTemplate = value;
                              fields = getDataReplace(value);
                              listaAdjuntos.clear();
                              _controllers.clear();
                            });
                          },
                          items: templates.map((template) {
                            return DropdownMenuItem<String>(
                              value: template['id'].toString(),
                              child: Text(
                                template['titulo'].toString().length > 28
                                    ? template['titulo'].toString().substring(0, 28)
                                    : template['titulo'].toString(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    if (selectedTemplate != null) ...[
                      _buildAsuntoCard(),
                      _buildAdjuntosCard(),
                      if (fields.isNotEmpty) _buildFieldsCard(),
                      _buildButtonsRow(),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAsuntoCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          onChanged: (value) => setState(() => asunto = value),
          decoration: InputDecoration(
            labelText: "Asunto",
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Widget _buildAdjuntosCard() {
    ScrollController _adjuntosScrollController = ScrollController(); // Controlador para la lista de adjuntos

    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _seleccionarAdjuntos,
            child: Text("Adjuntar Archivos"),
          ),
          if (listaAdjuntos.isNotEmpty)
            SizedBox(
              height: 120, // Asegura un tamaño fijo
              child: Scrollbar(
                controller: _adjuntosScrollController,
                thumbVisibility: true, // Siempre visible
                child: ListView.builder(
                  controller: _adjuntosScrollController,
                  itemCount: listaAdjuntos.length,
                  shrinkWrap: true, // Evita problemas con scroll infinito
                  itemBuilder: (context, index) {
                    var adjunto = listaAdjuntos[index];
                    return ListTile(
                      title: Text(
                        adjunto.nombre.length > 10
                            ? '${adjunto.nombre.substring(0, 10)}...'
                            : adjunto.nombre,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() => listaAdjuntos.removeAt(index));
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }


  Widget _buildFieldsCard() {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: fields.map((field) {
            return TextField(
              controller: _controllers.putIfAbsent(field, () => TextEditingController()),
              decoration: InputDecoration(labelText: field, border: OutlineInputBorder()),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildButtonsRow() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {
            Map<String, String> userValues = {};
            widget.sendMail.usaHTML = true;
            widget.sendMail.attachments = listaAdjuntos;
            widget.sendMail.replaceData = "";
            widget.sendMail.replaceData = template['replaceData'] as String;

            for (String field in fields) {
              userValues[field] = _controllers[field]?.text ?? "";
            }

            widget.sendMail.data = userValues;
            String html = utf8.decode(
                (template["formatoHtml"] as String).runes.toList());

            userValues.forEach((key, value) {
              html = html.replaceAll(
                  "[$key]", value.isNotEmpty ? value : "");
            });
            List<int> utf8Bytes = utf8.encode(html);
            String utf8Html = utf8.decode(utf8Bytes);

            widget.sendMail.sender = GlobalData.userName;
            widget.sendMail.subject = asunto;
            widget.sendMail.body = html;
            widget.onPreviewGenerated(utf8Html);
          }, child: Text("Preview")),
          SizedBox(width: 20),
          ElevatedButton(onPressed: () {}, child: Text("Send")),
        ],
      ),
    );
  }
}
