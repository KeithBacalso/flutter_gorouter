import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/user_cubit.dart';
import '../router/route_utils.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // final userBox = Hive.box('user');
            // userBox.put('isOnboarded', true);

            context.read<UserCubit>().onboard();

            // return context.goNamed(PAGE.home.name);
          },
          child: const Text('Done'),
        ),
      ),
    );
  }
}
