import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/user_cubit.dart';
import '../router/route_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Page'),
             ElevatedButton(
              onPressed: () {
                context.goNamed(PAGE.viewItem.name);
              },
              child: const Text('View Item'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<UserCubit>().logout();
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}