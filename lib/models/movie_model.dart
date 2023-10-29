import 'dart:convert';

class MovieModel {
  String id;
  String title;
  String description;
  int publishAt;
  String author;

  MovieModel(
      {this.id = "",
      required this.title,
      required this.description,
      required this.publishAt,
      required this.author});

  MovieModel.fromJason(Map<String, dynamic> json)
      : this(
          id: json['id'],
          title: json['title'],
          description: json['description'],
          publishAt: json['publishAt'],
          author: json['author'],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "publishAt": publishAt,
      "author":author
    };
  }
}
