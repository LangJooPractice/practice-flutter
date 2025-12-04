import 'package:dio/dio.dart';
import 'package:prac/models/article_model.dart';

class ArticleApiService {
  final Dio _dio = Dio();

  Future<List<ArticleModel>> fetchArticles() async {
    const url = 'https://693108ef11a8738467ccfc6c.mockapi.io/article_model';

    final response = await _dio.get(url);

    // response.data = List<dynamic>
    final List<dynamic> dataList = response.data;

    // JSON List -> List<ArticleModel>
    final articles = dataList
        .map((json) => ArticleModel.fromJson(json))
        .toList();

    return articles;
  }
}
