// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:prac/models/others/article_model.dart';
// import 'package:prac/models/others/isLiked_retweet_model.dart';
// import 'package:prac/provider/dio/dio_provider.dart';
// import 'package:prac/services/tweet/liked_api_service.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// //서버랑 통신합니다.
// final likedApiServiceProvider = Provider<LikedApiService>((ref) {
//   final dio = ref.read(dioProvider);
//   return LikedApiService(dio);
// });

// final likeProvider =
//     NotifierProvider.family<LikeNotifier, LikeState, ArticleModel>(
//       LikeNotifier.new,
//     );

// //1. 상태로서 LikeState를 가지는 class를 구현합니다.
// class LikeNotifier extends FamilyNotifier<LikeState, ArticleModel> {
//   @override
//   LikeState build(ArticleModel article) {
//     return LikeState(
//       isLiked: article.isLiked,
//       count: article.favorite_num.toInt(),
//     );
//   }

//   Future<void> toggleLike(String tweetId) async {
//     final api = ref.read(likedApiServiceProvider);
//     final response = await api.pressLike(tweetId);

//     state = state.copyWith(
//       isLiked: response,
//       count: response ? state.count + 1 : state.count - 1,
//     );
//   }
// }
