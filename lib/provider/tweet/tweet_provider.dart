import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac/models/others/tweet_detail_model.dart';
import 'package:prac/provider/dio/dio_provider.dart';
import 'package:prac/services/tweet/tweet_detail_service.dart';

final tweetDetailApiServiceProvider = Provider<TweetDetailService>((ref) {
  final dio = ref.watch(dioProvider);
  return TweetDetailService(dio);
});

final tweetDetailProvider = FutureProvider.family<TweetDetailModel, String>((
  ref,
  tweetId,
) async {
  final service = ref.watch(tweetDetailApiServiceProvider);
  return service.getTweetDetail(tweetId);
});
