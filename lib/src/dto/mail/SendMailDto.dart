import 'AdjuntosDto.dart';
import 'DestinatarioDto.dart';

class SendMailDto {
  int idCompania;
  String sender;
  bool usaHTML;
  String body;
  String subject;
  String replaceData;
  Map<String, dynamic> data;
  List<DestinatarioDto> to;
  List<DestinatarioDto> cco;
  List<AdjuntosDto>? attachments;

  // Constructor principal
  SendMailDto({
    required this.idCompania,
    required this.sender,
    required this.usaHTML,
    required this.body,
    required this.subject,
    required this.replaceData,
    required this.data,
    required this.to,
    required this.cco,
    this.attachments,
  });


  factory SendMailDto.iniciarClase() {
    return SendMailDto(
      idCompania: 0,
      sender: "",
      usaHTML: false,
      body: "",
      subject: "",
      replaceData: "",
      data: {},
      to: [],
      cco: [],
      attachments: [],
    );
  }

  factory SendMailDto.fromJson(Map<String, dynamic> json) {
    return SendMailDto(
      idCompania: json['idCompania'],
      sender: json['sender'],
      usaHTML: json['usaHTML'],
      body: json['body'],
      subject: json['subject'],
      replaceData: json['replaceData'],
      data: json['data'] ?? {},
      to: (json['to'] as List<dynamic>).map((e) => DestinatarioDto.fromJson(e)).toList(),
      cco: (json['cco'] as List<dynamic>).map((e) => DestinatarioDto.fromJson(e)).toList(),
      attachments: (json['attachments'] as List<dynamic>?)?.map((e) => AdjuntosDto.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCompania': idCompania,
      'sender': sender,
      'usaHTML': usaHTML,
      'body': body,
      'subject': subject,
      'replaceData': replaceData,
      'data': data,
      'to': to.map((e) => e.toJson()).toList(),
      'cco': cco.map((e) => e.toJson()).toList(),
      'attachments': attachments?.map((e) => e.toJson()).toList(),
    };
  }
}
