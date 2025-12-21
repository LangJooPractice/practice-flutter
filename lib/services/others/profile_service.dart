// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:prac/models/others/profile_model.dart';

class ProfileService {
  final Dio dio;
  ProfileService({required this.dio});

  Future<ProfileModel> getProfile(String? username) async {
    final res = await dio.get("/api/users/$username");

    return ProfileModel.fromJson(res.data);
  }
}
