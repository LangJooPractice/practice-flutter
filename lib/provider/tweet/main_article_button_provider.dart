import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:prac/provider/dio/dio_provider.dart';
import 'package:prac/services/tweet/liked_api_service.dart';

final likedApiServiceProvider = Provider<LikedApiService>((ref) {
  final dio = ref.read(dioProvider);
  return LikedApiService(dio);
});
