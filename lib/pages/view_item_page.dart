import 'package:flutter/material.dart';

class ViewItemParams {
  ViewItemParams({required this.a, required this.b});

  final String a;
  final int b;
}

class ViewItemPage extends StatelessWidget {
  const ViewItemPage({
    super.key,
    required this.id,
    required this.itemName,
    required this.samplePassedObject,
  });

  final int id;
  final String itemName;
  final ViewItemParams samplePassedObject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Item Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('View Item Page'),
            Text('Passed params & queryParams => $id $itemName'),
            Text(
                'Passed object => ${samplePassedObject.a} ${samplePassedObject.b}'),
          ],
        ),
      ),
    );
  }
}
