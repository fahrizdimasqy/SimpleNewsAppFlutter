class News {
  final String title;
  final String author;
  final String urlToImage;
  final String publishedAt;
  News({this.title, this.author, this.publishedAt, this.urlToImage});
  // factory News.fromJson(Map<String, dynamic> json) {
  //   return News(
  //       title: json['title'] as String,
  //       author: json['author'] as String,
  //       urlToImage: json['urlToImage'] as String,
  //       publishedAt: json['publishedAt'] as String);
  // }
}
