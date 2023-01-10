import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'cubit/user_cubit.dart';
import 'hive/user/user_hive.dart';
import 'router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(UserHiveAdapter());
  await Hive.openBox<UserHive>('user');

  //* Use this commented code if you are not using class generator from Hive.
  //* Otherwise do the above code registerAdapter thing.
  // await Future.wait([
  //   Hive.openBox('onboard'),
  //   Hive.openBox('login'),
  // ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit()..initialize(),
      child: MaterialApp.router(
        routerConfig: appRouter.router,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
