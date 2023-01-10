import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error Page')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(error),
        ),
      ),
    );
  }
}
