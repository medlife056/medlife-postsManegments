class UndesignedcounterModel {
  final String cellName;
  final int undesignedCount;

  UndesignedcounterModel({required this.cellName, required this.undesignedCount});

  factory UndesignedcounterModel.fromJson(Map<String, dynamic> json) {
    return UndesignedcounterModel(
      cellName: json['cell_name'],
      undesignedCount: json['undesigned_count'],
    );
  }
}
