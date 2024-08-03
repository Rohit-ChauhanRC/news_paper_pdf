// To parse this JSON data, do
//
//     final newsModel = newsModelFromMap(jsonString);

import 'dart:convert';

NewsModel newsModelFromMap(String str) => NewsModel.fromMap(json.decode(str));

String newsModelToMap(NewsModel data) => json.encode(data.toMap());

class NewsModel {
  int id;

  Content content;

  NewsModel({
    required this.id,
    required this.content,
  });

  factory NewsModel.fromMap(Map<String, dynamic> json) => NewsModel(
        id: json["id"],
        content: Content.fromMap(json["content"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "content": content.toMap(),
      };
}

class Content {
  String rendered;

  Content({
    required this.rendered,
  });

  factory Content.fromMap(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
      );

  Map<String, dynamic> toMap() => {
        "rendered": rendered,
      };
}
