// class articles{
//   String author;
//   String title;
//   String description;
//   String url;
//   String imgurl;
//   String publishedat;
//   String content;
//   articles({required this.author,
//   required this.title,
//   required this.description,
//   required this.url,
//   required this.imgurl,
//   required this.publishedat,
//   required this.content});


//     factory articles.fromJson(Map<String, dynamic> json) {
//     return articles(
//       title: json['title']??'No title',
//       author: json['author']??'no author data',
//       description: json['description']??'no description data',
//       url: json['url']??'no url avilable' ,
//       imgurl: json['imgurl']??'',
//       publishedat: json['publishedat']??'no published data',
//       content: json['content']??'no content avilable',
   
//     );
//   }
  

// }
// news_model.dart
class NewsResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;

  NewsResponse({required this.status, required this.totalResults, required this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: List<Article>.from(json['articles'].map((article) => Article.fromJson(article))),
    );
  }
}

class Article {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'] ?? '',
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'],
      content: json['content'] ?? '',
    );
  }
}

class Source {
  final String id;
  final String name;

  Source({required this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] ?? '',
      name: json['name'],
    );
  }
}
