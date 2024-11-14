// news_article.dart

import 'dart:convert';

class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String author;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.author,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      author: json['author'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': imageUrl,
        'author': author,
      };

  String toJsonString() => jsonEncode(toJson());

  factory NewsArticle.fromMapLocal(String jsonString) {
    return NewsArticle.fromJson(jsonDecode(jsonString));
  }
}

class NewsResponse {
  final List<NewsArticle> articles;
  final int totalResults;

  NewsResponse({required this.articles, required this.totalResults});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['articles'] as List;
    List<NewsArticle> articles = list.map((i) => NewsArticle.fromJson(i)).toList();
    return NewsResponse(
      articles: articles,
      totalResults: json['totalResults'],
    );
  }
}
