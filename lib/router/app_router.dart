import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_router/pages/favorites_page.dart';

import '../cubit/user_cubit.dart';
import '../hive/hive_box.dart';
import '../hive/user/user_hive.dart';
import '../pages/error_page.dart';
import '../pages/root_page.dart';
import '../pages/onboarding_page.dart';
import '../pages/sign_in_page.dart';
import '../pages/sign_up_page.dart';
import '../pages/splash_page.dart';
import '../pages/view_item_page.dart';
import '../pages/profile_page.dart';
import 'route_utils.dart';

class AppRouter {
  //* ===== PAGES =====
  static Widget _splashPage(BuildContext context, GoRouterState state) {
    return const SplashPage();
  }

  static Widget _signinPage(BuildContext context, GoRouterState state) {
    return const SignInPage();
  }

  static Widget _signupPage(BuildContext context, GoRouterState state) {
    return const SignUpPage();
  }

  static Widget _onboardingPage(BuildContext context, GoRouterState state) {
    return const OnboardingPage();
  }

  static Widget _homePage(BuildContext context, GoRouterState state) {
    return const RootPage();
  }

  static Widget _viewItemPage(BuildContext context, GoRouterState state) {
    return ViewItemPage(
      id: int.parse(state.params['id']!),
      itemName: state.queryParams['itemName'] ?? '',
      params: state.extra as ViewItemParams,
    );
  }

  static Widget _errorPage(BuildContext context, GoRouterState state) {
    return ErrorPage(error: state.error.toString());
  }

  //* === REDIRECTIONS ===
  static FutureOr<String?> _redirectToHome(
      BuildContext context, GoRouterState state) {
    return PAGE.home.path;
  }

  //* === ROUTER ===
  String _initLocation() {
    //* Use this uncommented code if you are not using class generator from Hive.
    // final loginBox = Hive.box('login');
    // final onboardBox = Hive.box('onboard');

    // final isLoggedin = loginBox.get('isLoggedIn') ?? false;
    // final isOnboarded = onboardBox.get('isOnboard') ?? false;

    final userBox = HiveBox.getUser();
    final isLoggedin = userBox.get('isLoggedIn')?.isLoggedIn ?? false;
    final isOnboarded = userBox.get('isOnboarded')?.isOnboarded ?? false;

    if (!isLoggedin) {
      return PAGE.signin.path;
    }

    if (isLoggedin && !isOnboarded) {
      return PAGE.onboarding.path;
    }

    return PAGE.home.path;
  }

  late final GoRouter router = GoRouter(
    initialLocation: _initLocation(),
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: PAGE.signin.path,
        name: PAGE.signin.name,
        builder: _signinPage,
        routes: [
          GoRoute(
            path: PAGE.signup.path,
            name: PAGE.signup.name,
            builder: _signupPage,
          ),
        ],
      ),

      GoRoute(
        path: PAGE.onboarding.path,
        name: PAGE.onboarding.name,
        builder: _onboardingPage,
      ),
      GoRoute(
        path: PAGE.root.path,
        name: PAGE.root.name,
        redirect: _redirectToHome,
      ),

      //* === UNCOMMENT CODE TO TRY ===
      //* These 3 routes home, favorites, and profile are the Root Page bottom nav items.
      //* We used redirect: to them instead of builder: because if we used builder:
      //* it will only navigate to its single page not including the bottom nav bar items.
      GoRoute(
        path: PAGE.home.path,
        name: PAGE.home.name,
        builder: _homePage,
        routes: [
          GoRoute(
            path: PAGE.viewItem.path,
            name: PAGE.viewItem.name,
            builder: _viewItemPage,
          ),
        ],
      ),
      GoRoute(
        path: PAGE.favorites.path,
        name: PAGE.favorites.name,
        redirect: _redirectToHome,
      ),
      GoRoute(
        path: PAGE.profile.path,
        name: PAGE.profile.name,
        redirect: _redirectToHome,
      ),

      //* This error page inside routes is used for manually navigating the user here.
      GoRoute(
        path: PAGE.error.path,
        name: PAGE.error.name,
        builder: _errorPage,
      ),
    ],
    errorBuilder: _errorPage,
  );
}
