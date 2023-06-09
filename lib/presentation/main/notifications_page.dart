import 'package:flutter/material.dart';

import '../../core.dart/resources/string_manager.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppString.notifications),
    );
  }
}
