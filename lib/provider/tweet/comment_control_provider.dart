import 'package:flutter_riverpod/legacy.dart';

enum CommentControl { everyone, authenticated, following, mentioned }

final commentControlProvider = StateProvider<CommentControl>((ref) {
  return CommentControl.everyone;
});
