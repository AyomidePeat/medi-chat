import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medi_query/model/blog_model.dart';

import 'package:http/http.dart' as http;

final blogApiProvider = Provider<BlogPostApi>((ref) => BlogPostApi());

class BlogPostApi {
  Future<List<BlogPost>> getBlogPost() async {
    try {
      String apiKey = '15858879426a9792027dbac4288572f1';
      
      String endpoint =
          'https://gnews.io/api/v4/top-headlines?category=health&lang=en&token=$apiKey';

      final response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<Map<String, dynamic>> newsDataList =
            (jsonData['articles'] as List).cast<Map<String, dynamic>>();
        List<BlogPost> newsList = newsDataList
            .map((newsData) => BlogPost.fromJson(newsData))
            .toList();
        return newsList;
      } else {
        print('Failed to fetch news. Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Failed to fetch news. Exception: $e');
      return [];
    }
  }
}
