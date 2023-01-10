import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key, required this.name, required this.gender, required this.age});

  final String name;
  final String gender;
  final int age;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Favorites Page'),
            Text(name),
            Text(gender),
            Text(age.toString()),
          ],
        ),
      ),
    );
  }
}
