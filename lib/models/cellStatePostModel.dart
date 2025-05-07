class CellPostsStatsModel {
  final String cellName;
  final int publishedPosts;

  CellPostsStatsModel({
    required this.cellName,
    required this.publishedPosts,
  });

  factory CellPostsStatsModel.fromJson(Map<String, dynamic> json) {
    return CellPostsStatsModel(
      cellName: json['cell_name'],
      publishedPosts: json['published_posts'],
    );
  }
}
