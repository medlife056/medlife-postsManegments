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
      id: json['id'],
      name: json['name'],
      status: json['status'],
      cell: json['cell'],
      position: json['position'],
      publishedPosts: json['published_posts'],
    );
  }
}
