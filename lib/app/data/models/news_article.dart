class NewsArticle {
  final String title;
  final String link;

  NewsArticle({required this.title, required this.link});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      link: json['link'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "link": link,
    };
  }
}
