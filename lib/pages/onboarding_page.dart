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
            context.read<UserCubit>().onboard();

            context.goNamed(PAGE.home.name);

            //* === UNCOMMENT CODE TO TRY ===
            //* Try uncommenting this code for errorBuilder: of GoRouter to work.
            // context.go('${PAGE.home.path}/asdf');
          },
          child: const Text('Done'),
        ),
      ),
    );
  }
}
