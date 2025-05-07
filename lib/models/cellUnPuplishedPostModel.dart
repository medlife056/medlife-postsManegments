class CellUnPuplishedPostsModel {
  final String cellName;
  final int unpublishedPosts;

  CellUnPuplishedPostsModel({
    required this.cellName,
    required this.unpublishedPosts,
  });

  factory CellUnPuplishedPostsModel.fromJson(Map<String, dynamic> json) {
    return CellUnPuplishedPostsModel(
      cellName: json['cell_name'],
      unpublishedPosts: json['unpublished_posts'],
    );
  }
}
