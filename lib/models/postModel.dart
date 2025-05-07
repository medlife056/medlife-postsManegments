class PostModel {
  final int id;
  final String postIdea;
  final String writtenBy;
  final int isCoordinated;
  final int isDesigned;
  final int isPublished;
  final String cellId;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.postIdea,
    required this.writtenBy,
    required this.isCoordinated,
    required this.isDesigned,
    required this.isPublished,
    required this.cellId,
    required this.createdAt,
  });

 factory PostModel.fromJson(Map<String, dynamic> json) {
  return PostModel(
    id: json['id'],
    postIdea: json['post_idea'],
    writtenBy: json['written_by'],
    isCoordinated: json['is_coordinated'] ? 1 : 0,
    isDesigned: json['is_designed'] ? 1 : 0,
    isPublished: json['is_published'] ? 1 : 0,
    cellId: json['cell_id'],
    createdAt: DateTime.parse(json['created_at']),
  );
}
}
