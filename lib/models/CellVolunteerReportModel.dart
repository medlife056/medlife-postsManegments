class CellVolunteerReportModel {
  final int id;
  final String name;
  final String status;
  final String cell;
  final String position;
  final int publishedPosts;

  CellVolunteerReportModel({
    required this.id,
    required this.name,
    required this.status,
    required this.cell,
    required this.position,
    required this.publishedPosts,
  });

  factory CellVolunteerReportModel.fromJson(Map<String, dynamic> json) {
    return CellVolunteerReportModel(
      id: json['id'] ?? 0,
      name: json['full_name'] ?? '',
      status: json['academic_status'] ?? '',
      cell: json['governorate'] ?? '', // closest match in response
      position: json['specialization'] ?? '',
      publishedPosts: json['tasks_count'] ?? 0,
    );
  }
}
