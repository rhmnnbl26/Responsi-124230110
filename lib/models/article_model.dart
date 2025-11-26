/// Model class untuk data Article, Blog, dan Report dari Spaceflight News API
/// Digunakan untuk mapping JSON response dari API ke object Dart
class Article {
  final int id;
  final String title;
  final String url;
  final String imageUrl;
  final String newsSite;
  final String summary;
  final String publishedAt;
  final String updatedAt;
  final bool featured;

  /// Constructor untuk Article model
  Article({
    required this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.newsSite,
    required this.summary,
    required this.publishedAt,
    required this.updatedAt,
    required this.featured,
  });

  /// Factory constructor untuk membuat Article object dari JSON
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['image_url'] ?? '',
      newsSite: json['news_site'] ?? '',
      summary: json['summary'] ?? '',
      publishedAt: json['published_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      featured: json['featured'] ?? false,
    );
  }

  /// Method untuk convert Article object ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'image_url': imageUrl,
      'news_site': newsSite,
      'summary': summary,
      'published_at': publishedAt,
      'updated_at': updatedAt,
      'featured': featured,
    };
  }

  /// Override operator == untuk perbandingan object
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Article && other.id == id;
  }

  /// Override hashCode untuk digunakan di Set dan Map
  @override
  int get hashCode => id.hashCode;
}
