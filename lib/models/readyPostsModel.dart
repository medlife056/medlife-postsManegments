class ReadyPostModel {
  final int id;
  final String postIdea;
  final String writtenBy;
  final bool isCoordinated;
  final bool isDesigned;
  final bool needDesign;
  final bool isPublished;
  final String coordinatedBy;
  final String coordinatedAt;
  final String designedBy;
  final String designedAt;
  final String cellId;
  final String createdAt;
  final String updatedAt;

  ReadyPostModel({
    required this.id,
    required this.postIdea,
    required this.writtenBy,
    required this.isCoordinated,
    required this.isDesigned,
    required this.needDesign,
    required this.isPublished,
    required this.coordinatedBy,
    required this.coordinatedAt,
    required this.designedBy,
    required this.designedAt,
    required this.cellId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReadyPostModel.fromJson(Map<String, dynamic> json) {
    return ReadyPostModel(
      id: json['id'],
      postIdea: json['post_idea'] ?? '',
      writtenBy: json['written_by'] ?? '',
      isCoordinated: json['is_coordinated'] == 1,
      isDesigned: json['is_designed'] == 1,
      needDesign: json['need_design'] == 1,
      isPublished: json['is_published'] == 1,
      coordinatedBy: json['coordinated_by'] ?? '',
      coordinatedAt: json['coordinated_at'] ?? '',
      designedBy: json['designed_by'] ?? '',
      designedAt: json['designed_at'] ?? '',
      cellId: json['cell_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
