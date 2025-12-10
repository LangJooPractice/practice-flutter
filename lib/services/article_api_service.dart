import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:prac/models/article_model.dart';

class ArticleApiService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://693108ef11a8738467ccfc6c.mockapi.io/'),
  );

  //FETCH
  Future<List<ArticleModel>> fetchArticles() async {
    final response = await _dio.get("article_model");

    // response.data = List<dynamic>
    final List<dynamic> dataList = response.data;

    // JSON List -> List<ArticleModel>
    final articles = dataList
        .map((json) => ArticleModel.fromJson(json))
        .toList();

    return articles;
  }

  //POST
  Future<void> postArticle(String content) async {
    try {
      final request = await _dio.post(
        "article_model",
        data: {"article_string": content},
      );
      if (request.statusCode != 201) {
        throw Exception(
          '게시글 post 실패 : ${request.statusCode} : ${request.data}',
        );
      }
    } catch (e) {
      throw Exception("오류 발생 : $e");
    }
  }
}
