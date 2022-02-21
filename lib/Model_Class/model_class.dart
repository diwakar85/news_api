class News {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  News(
      {this.title,
      this.description,
      this.author,
      this.content,
      this.publishedAt,
      this.url,
      this.urlToImage}
      );

  factory News.fromjson(Map<String, dynamic> json) {
    return News(
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'],
        content: json['content']);
  }
}
