class CellBankStats {
  final int publishedIdeas;
  final int readyButNotPublished;
  final int pendingCoordination;
  final int pendingDesign;

  CellBankStats({
    required this.publishedIdeas,
    required this.readyButNotPublished,
    required this.pendingCoordination,
    required this.pendingDesign,
  });

  factory CellBankStats.fromJson(Map<String, dynamic> json) {
    return CellBankStats(
      publishedIdeas: json['published_ideas'],
      readyButNotPublished: json['ready_but_not_published'],
      pendingCoordination: json['pending_coordination'],
      pendingDesign: json['pending_design'],
    );
  }
}
