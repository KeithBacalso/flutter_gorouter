import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_router/pages/favorites_page.dart';

import '../cubit/user_cubit.dart';
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
  // ===== PAGES =====
  static Widget _splashPage(BuildContext context, GoRouterState state) {
    return const SplashPage();
  }
  static Widget _signinPage(BuildContext context, GoRouterState state) =>
      const SignInPage();
  static Widget _signupPage(BuildContext context, GoRouterState state) =>
      const SignUpPage();
  static Widget _onboardingPage(BuildContext context, GoRouterState state) =>
      const OnboardingPage();
  static Widget _rootPage(BuildContext context, GoRouterState state) =>
      const RootPage();
  static Widget _viewItemPage(BuildContext context, GoRouterState state) =>
      const ViewItemPage();
  static Widget _favoritesPage(BuildContext context, GoRouterState state) =>
      const FavoritesPage();
  static Widget _profilePage(BuildContext context, GoRouterState state) =>
      const ProfilePage();
  static Widget _errorPage(BuildContext context, GoRouterState state) =>
      const ErrorPage();

  String _initLocation() {
    final loginBox = Hive.box('login');
    final onboardBox = Hive.box('onboard');

    final isLoggedin = loginBox.get('isLoggedIn') ?? false;
    final isOnboarded = onboardBox.get('isOnboard') ?? false;

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
        path: PAGE.home.path,
        name: PAGE.home.name,
        builder: _rootPage,
        routes: [
          GoRoute(
            path: PAGE.viewItem.path,
            name: PAGE.viewItem.name,
            builder: _viewItemPage,
          ),
        ],
      ),

      //* === UNCOMMENT CODE TO TRY ===
      //* These 3 routes home, favorites, and profile are the Root Page bottom nav items.
      //* We used redirect: to them instead of builder: because if we used builder:
      //* it will only navigate to its single page not including the bottom nav bar items.
      GoRoute(
        path: PAGE.home.path,
        redirect: (context, state) => PAGE.home.path,
      ),
      GoRoute(
        path: PAGE.favorites.path,
        redirect: (context, state) => PAGE.home.path,
      ),
      GoRoute(
        path: PAGE.profile.path,
        redirect: (context, state) => PAGE.home.path,
      ),

      //* This error page inside routes is used for manually navigating the user here.
      GoRoute(
        path: PAGE.error.path,
        name: PAGE.error.name,
        builder: _errorPage,
      ),
    ],
  );
}
