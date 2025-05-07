class AppLink {
  static const String server = "http://192.168.77.30:8000/api";
  static const String images = "http://192.168.77.30:8000";

  static const String test = "$server/test.php";
  //////////////////Auth///////////////////
  static const String createWriter = "$server/register";
  static const String login = "$server/login";
  static const String logout = "$server/logout";

  ///////////////Admin APIs////////////////

  static const String cellsWithNumberOfPublishedPosts =
      "$server/cell_posts_stats";
  static const String cellUnPuplishedPosts = "$server/cell_posts_not_stats";
  static const String postsReport = "$server/posts";

  ///// showCell Api///////////////////
  static const String showCells = "$server/cells";

  ///////////////Designer APIs////////////////

  static const String cellUnDesignedCounter = "$server/cell_UnDesigned_stats";
  static const String UndesignedPost = "$server/posts/unDesigned?cell_id";
  static const String editPost = "$server/post";
  static const String volunteer = "$server/volunteers";

  ///////////////Coordinate APIs////////////////

  static const String cellUnCoordinatedCounter =
      "$server/cell_UnCoordinated_stats";
  static const String UnCoordinatedPost = "$server/posts/unCoordinated?cell_id";

  ///////////////Content Writer APIs////////////////

  static const String addPost = "$server/post";
  static const String cellBankReport = "$server/cell_stats?cell_id";
  static const String cellVolunteersReport =
      "$server/cell_volunteers_stats?cell_id";
  static const String readyPosts = "$server/posts/ready";
}
