class Company {
  final String title;
  final String description;

  Company({required this.title, required this.description});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      title: json['nombre'] ?? 'Sin título',
      description: json['descripcion'] ?? 'Sin descripción',
    );
  }
}
