class SearchBodyModel {
  final String q;
  final String searchIn;
  final int page;
  final int pageSize;
  final String sortBy;

  SearchBodyModel({
    required this.q,
    this.searchIn = "title",
    this.page = 4,
    this.pageSize = 10,
    this.sortBy = "publishedAt",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'q': q,
      'searchIn': searchIn,
      'page': page,
      'pageSize': pageSize,
      'sortBy': sortBy,
    };
  }

  factory SearchBodyModel.fromMap(Map<String, dynamic> map) {
    return SearchBodyModel(
      q: map['q'] as String,
      searchIn: map['searchIn'] as String,
      page: map['page'] as int,
      pageSize: map['pageSize'] as int,
      sortBy: map['sortBy'] as String,
    );
  }
}
