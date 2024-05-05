// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ErrorLayout extends StatelessWidget {
  final String message;
  final VoidCallback? onRefresh;
  const ErrorLayout({
    required this.message,
    super.key,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          if (onRefresh != null) ElevatedButton(onPressed: onRefresh, child: const Text('try againt')),
        ],
      ),
    );
  }
}
