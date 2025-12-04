import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Notification extends ConsumerStatefulWidget {
  const Notification({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationState();
}

class _NotificationState extends ConsumerState<Notification> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("This is Notification page"));
  }
}
