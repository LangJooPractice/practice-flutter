// ignore_for_file: public_member_api_docs, sort_constructors_first
class LikeState {
  final bool isLiked;
  final int likeCount;
  LikeState({required this.isLiked, required this.likeCount});

  LikeState copyWith({bool? isLiked, int? likeCount, bool? isLoading}) {
    return LikeState(
      isLiked: isLiked ?? this.isLiked,
      likeCount: likeCount ?? this.likeCount,
    );
  }
}
