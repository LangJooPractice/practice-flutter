import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac/models/article_model.dart';
import 'package:prac/services/article_api_service.dart';

final articleApiServiceProvider = Provider<ArticleApiService>((ref) {
  return ArticleApiService();
});

final ArticleProvider = FutureProvider<List<ArticleModel>>((ref) async {
  final articleApiService = ref.watch(articleApiServiceProvider);
  return articleApiService.fetchArticles();
});
