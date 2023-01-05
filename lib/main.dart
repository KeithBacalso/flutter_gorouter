import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_router/cubit/user_cubit.dart';

import 'cubit/login_cubit.dart';
import 'router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Future.wait([
    Hive.openBox('initialize'),
    Hive.openBox('onboard'),
    Hive.openBox('login'),
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserCubit()..initialize(),
        ),
        BlocProvider(
          create: (_) => LoginCubit(),
        ),
      ],
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return MaterialApp.router(
                routeInformationProvider: AppRouter(context.read<UserCubit>())
                    .router
                    .routeInformationProvider,
                routeInformationParser: AppRouter(context.read<UserCubit>())
                    .router
                    .routeInformationParser,
                routerDelegate:
                    AppRouter(context.read<UserCubit>()).router.routerDelegate,
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
