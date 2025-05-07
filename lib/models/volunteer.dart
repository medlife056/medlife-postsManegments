class Volunteer {
  final int id;
  final String name;

  Volunteer({required this.id, required this.name});

  factory Volunteer.fromJson(Map<String, dynamic> json) {
    return Volunteer(id: json['id'], name: json['name']);
  }
}
