import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Message extends ConsumerStatefulWidget {
  const Message({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageState();
}

class _MessageState extends ConsumerState<Message> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("This is Message page"));
  }
}
