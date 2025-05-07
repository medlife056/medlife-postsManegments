class UnCoordinatedcounterModel {
  final String cellName;
  final int uncoordinateCount;

  UnCoordinatedcounterModel({
    required this.cellName,
    required this.uncoordinateCount,
  });

  factory UnCoordinatedcounterModel.fromJson(Map<String, dynamic> json) {
    return UnCoordinatedcounterModel(
      cellName: json['cell_name'],
      uncoordinateCount: json['uncoordinated_count'],
    );
  }
}
