class PostUpdateModel {
  final int id;
  String? postIdea;
  String? writtenBy;
  int? isCoordinated;
  int? isDesigned;
  int? isPublished;
  String? designedBy;
  DateTime? designedAt;
  String? coordinatedBy;
  DateTime? coordinatedAt;

  PostUpdateModel({
    required this.id,
    this.postIdea,
    this.writtenBy,
    this.isCoordinated,
    this.isDesigned,
    this.isPublished,
    this.designedBy,
    this.designedAt,
    this.coordinatedBy,
    this.coordinatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      if (postIdea != null) 'post_idea': postIdea,
      if (writtenBy != null) 'written_by': writtenBy,
      if (isCoordinated != null) 'is_coordinated': isCoordinated,
      if (isDesigned != null) 'is_designed': isDesigned,
      if (isPublished != null) 'is_published': isPublished,
      if (designedBy != null) 'designed_by': designedBy,
      if (designedAt != null) 'designed_at': designedAt?.toIso8601String(),
      if (coordinatedBy != null) 'coordinated_by': coordinatedBy,
      if (coordinatedAt != null) 'coordinated_at': coordinatedAt?.toIso8601String(),
    };
  }
}
