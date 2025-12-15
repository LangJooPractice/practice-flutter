class LikeState {
  final bool isLiked;
  final int count;

  LikeState({required this.isLiked, required this.count});

  LikeState copywith({bool? isLiked, int? count}) {
    return LikeState(
      isLiked: isLiked ?? this.isLiked,
      count: count ?? this.count,
    );
  }
}
