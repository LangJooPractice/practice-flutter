// ignore_for_file: public_member_api_docs, sort_constructors_first
class LikeState {
  final int likeCount;
  final bool liked;

  LikeState({required this.likeCount, required this.liked});

  LikeState copyWith(int? likeCount, bool? liked) {
    return LikeState(
      likeCount: likeCount ?? this.likeCount,
      liked: liked ?? this.liked,
    );
  }
}
