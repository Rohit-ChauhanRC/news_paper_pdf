// To parse this JSON data, do
//
//     final newsModel = newsModelFromMap(jsonString);

import 'dart:convert';

NewsModel newsModelFromMap(String str) => NewsModel.fromMap(json.decode(str));

String newsModelToMap(NewsModel data) => json.encode(data.toMap());

class NewsModel {
  int? id;

  Content? content;
  Content? excerpt;

  NewsModel({
    this.id,
    this.content,
    this.excerpt,
  });

  factory NewsModel.fromMap(Map<String, dynamic> json) => NewsModel(
        id: json["id"],
        content:
            json["content"] == null ? null : Content.fromMap(json["content"]),
        excerpt:
            json["excerpt"] == null ? null : Content.fromMap(json["excerpt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "content": content?.toMap(),
        "excerpt": excerpt?.toMap(),
      };
}

class Content {
  String? rendered;
  bool? protected;

  Content({
    this.rendered,
    this.protected,
  });

  factory Content.fromMap(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
        protected: json["protected"],
      );

  Map<String, dynamic> toMap() => {
        "rendered": rendered,
        "protected": protected,
      };
}
