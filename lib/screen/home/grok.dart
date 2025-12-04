import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Grok extends ConsumerStatefulWidget {
  const Grok({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GrokState();
}

class _GrokState extends ConsumerState<Grok> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("This is Grok page"));
  }
}
