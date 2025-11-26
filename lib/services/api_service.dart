import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

enum ContentType { articles, blogs, reports }

class ApiService {
  static const String baseUrl = 'https://api.spaceflightnewsapi.net/v4';
  
  // Singleton instance
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  /// Method untuk fetch articles, blogs, atau reports dari API
  /// Parameter: type - jenis konten (articles, blogs, reports)
  /// Returns: List<Article> jika berhasil
  Future<List<Article>> getContent(ContentType type) async {
    try {
      String endpoint;
      switch (type) {
        case ContentType.articles:
          endpoint = 'articles';
          break;
        case ContentType.blogs:
          endpoint = 'blogs';
          break;
        case ContentType.reports:
          endpoint = 'reports';
          break;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/$endpoint/'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        if (data.containsKey('results')) {
          final List<dynamic> resultsList = data['results'];
          return resultsList.map((json) => Article.fromJson(json)).toList();
        } else {
          throw Exception('Invalid response format: missing results field');
        }
      } else {
        throw Exception('Failed to load content. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching content: $e');
    }
  }

  /// Method untuk fetch detail article berdasarkan ID
  /// Parameter: type - jenis konten, id - ID artikel
  /// Returns: Article object
  Future<Article> getContentById(ContentType type, int id) async {
    try {
      String endpoint;
      switch (type) {
        case ContentType.articles:
          endpoint = 'articles';
          break;
        case ContentType.blogs:
          endpoint = 'blogs';
          break;
        case ContentType.reports:
          endpoint = 'reports';
          break;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/$endpoint/$id/'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Article.fromJson(data);
      } else {
        throw Exception('Failed to load content detail. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching content detail: $e');
    }
  }

  /// Method untuk search content berdasarkan title
  Future<List<Article>> searchContent(ContentType type, String query) async {
    try {
      final allContent = await getContent(type);
      
      if (query.isEmpty) {
        return allContent;
      }
      
      return allContent.where((article) {
        return article.title.toLowerCase().contains(query.toLowerCase()) ||
               article.summary.toLowerCase().contains(query.toLowerCase()) ||
               article.newsSite.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } catch (e) {
      throw Exception('Error searching content: $e');
    }
  }
}
