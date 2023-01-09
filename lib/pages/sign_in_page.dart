import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/user_cubit.dart';
import '../router/route_utils.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign In Page'),
            const SizedBox(height: 10),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, userState) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<UserCubit>().login();

                    final isOnboarded = userState.isOnboarded;

                    if (!isOnboarded) {
                      context.goNamed(PAGE.onboarding.name);
                      return;
                    }

                    context.goNamed(PAGE.home.name);
                  },
                  child: const Text('Sign In'),
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.goNamed(PAGE.signup.name),
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
