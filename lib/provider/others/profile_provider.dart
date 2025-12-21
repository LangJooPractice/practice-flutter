import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac/models/others/profile_model.dart';
import 'package:prac/provider/auth/login_provider.dart';
import 'package:prac/provider/dio/dio_provider.dart';
import 'package:prac/screen/tweet_profile/profile.dart';
import 'package:prac/services/others/profile_service.dart';

final profileApiServiceProvider = Provider<ProfileService>((ref) {
  final dio = ref.watch(dioProvider);

  return ProfileService(dio: dio);
});

final profileProvider = FutureProvider<ProfileModel>((ref) async {
  final api = ref.watch(profileApiServiceProvider);
  final String? username = ref.read(loginProvider.notifier).getUsername();
  debugPrint("username = $username");

  return api.getProfile(username);
});
