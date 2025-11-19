class TopHeadlinesBodyModel {
  final String country;
  final String? category;
  final String? q;
  final String? sources;
  final int? page;
  final int? pageSize;

  TopHeadlinesBodyModel({
    this.country = "us",
    this.category,
    this.q,
    this.page,
    this.pageSize,
    this.sources,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'country': country,
      'category': category,
      'q': q,
      'page': page,
      'pageSize': pageSize,
      'sources': sources,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  factory TopHeadlinesBodyModel.fromMap(Map<String, dynamic> map) {
    return TopHeadlinesBodyModel(
      country: map['country'] as String,
      category: map['category'] != null ? map['category'] as String : null,
      q: map['q'] != null ? map['q'] as String : null,
      page: map['page'] != null ? map['page'] as int : null,
      pageSize: map['pageSize'] != null ? map['pageSize'] as int : null,
    );
  }
}
