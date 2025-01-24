

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeftColumn extends StatefulWidget {
  @override
  _LeftColumnState createState() => _LeftColumnState();
}

class _LeftColumnState extends State<LeftColumn> {
  bool isExpanded = true;
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

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
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
                    fields = List.generate(5, (index) => "Field \${index + 1}");
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
                child: SingleChildScrollView(
                  child: Column(
                    children: fields.map((field) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: field,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: () {
                print("Preview generated for \$selectedTemplate");
              },
              child: Text("Preview"),
            ),
          ],
        ],
      ),
    );
  }
}