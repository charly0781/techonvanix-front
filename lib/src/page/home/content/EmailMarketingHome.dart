import 'package:flutter/material.dart';


class EmailMarketingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plataforma de Email Marketing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EmailMarketingHome(),
    );
  }
}

class EmailMarketingHome extends StatelessWidget {
  final List<Map<String, dynamic>> features = [
    {'icon': Icons.drag_indicator, 'text': 'Generador de plantillas'},
    {'icon': Icons.email, 'text': 'Planes de correo ilimitados'},
    {'icon': Icons.verified_user, 'text': 'Historial de envio correo'},
    {'icon': Icons.storage, 'text': 'desde 2mb adjuntos por correo'},
    {'icon': Icons.autorenew, 'text': 'Flujos automatizados'},
    {'icon': Icons.pie_chart, 'text': 'Segmentación avanzada'},
    {'icon': Icons.pin_end, 'text': 'Integracionas mucho mas sencillas'},
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*Text(
            "Mis Funcionalidades",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),*/
          SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: features.map((feature) {
              return SizedBox(
                width: (MediaQuery.of(context).size.width / (screenWidth > 500 ? 4 : 2 )) - 25,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(feature['icon'], size: 40, color: Colors.blue),
                        SizedBox(height: 10),
                        Text(
                          feature['text'],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

