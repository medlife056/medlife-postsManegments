class CellModel {
  final int id;
  final String name;

  CellModel({required this.id, required this.name});

  factory CellModel.fromJson(Map<String, dynamic> json) {
    return CellModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
