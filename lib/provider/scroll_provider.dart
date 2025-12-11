import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//메인 페이지의 ScrollController Provider
final scrollControllerProvider = Provider<ScrollController>((ref) {
  final controller = ScrollController(
    keepScrollOffset: true,
    initialScrollOffset: 0,
  );

  ref.onDispose(() {
    controller.dispose();
  });

  return controller;
});
