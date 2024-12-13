// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class NewsListModel extends Equatable {
  final String title;
  final String code;
  final String imagePath;

  const NewsListModel({
    required this.title,
    required this.code,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'code': code,
      'imagePath': imagePath,
    };
  }

  factory NewsListModel.fromMap(Map<String, dynamic> map) {
    return NewsListModel(
      title: map['title'] as String,
      code: map['code'] as String,
      imagePath: map['imagePath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsListModel.fromJson(String source) =>
      NewsListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [title, code, imagePath];
}
