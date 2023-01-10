import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_router/pages/view_item_page.dart';

import '../cubit/user_cubit.dart';
import '../router/route_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Home Page'),
          ElevatedButton(
            onPressed: () {
              context.goNamed(
                PAGE.viewItem.name,
                params: {'id': '123'},
                queryParams: {'itemName': 'Love'},
                extra: SamplePassedObject(a: 'Keith', b: 24),
              );
            },
            child: const Text('View Item'),
          ),
        ],
      ),
    );
  }
}
