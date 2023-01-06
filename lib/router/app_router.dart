import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../cubit/user_cubit.dart';
import '../pages/error_page.dart';
import '../pages/home_page.dart';
import '../pages/onboarding_page.dart';
import '../pages/sign_in_page.dart';
import '../pages/sign_up_page.dart';
import '../pages/splash_page.dart';
import '../pages/view_item_page.dart';
import '../pages/view_profile_page.dart';
import 'route_utils.dart';

class AppRouter {
  AppRouter(this.userCubit);
  final UserCubit userCubit;

  // ===== PAGES =====
  static Widget _splashPage(BuildContext context, GoRouterState state) =>
      const SplashPage();
  static Widget _signinPage(BuildContext context, GoRouterState state) =>
      const SignInPage();
  static Widget _signupPage(BuildContext context, GoRouterState state) =>
      const SignUpPage();
  static Widget _onboardingPage(BuildContext context, GoRouterState state) =>
      const OnboardingPage();
  static Widget _homePage(BuildContext context, GoRouterState state) =>
      const HomePage();
  static Widget _viewItemPage(BuildContext context, GoRouterState state) =>
      const ViewItemPage();
  static Widget _viewProfilePage(BuildContext context, GoRouterState state) =>
      const ViewProfilePage();
  static Widget _errorPage(BuildContext context, GoRouterState state) =>
      const ErrorPage();

  late final GoRouter router = GoRouter(
    refreshListenable: GoRouterRefreshStream(userCubit.stream),
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: PAGE.splash.path,
        name: PAGE.splash.name,
        builder: _splashPage,
      ),
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
        builder: _homePage,
        routes: [
          GoRoute(
            path: PAGE.viewItem.path,
            name: PAGE.viewItem.name,
            builder: _viewItemPage,
          ),
          GoRoute(
            path: PAGE.viewProfile.path,
            name: PAGE.viewProfile.name,
            builder: _viewProfilePage,
          ),
        ],
      ),

      //* This error page inside routes is used for manually navigating the user here.
      GoRoute(
        path: PAGE.error.path,
        name: PAGE.error.name,
        builder: _errorPage,
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.extra.toString()),
    redirect: (context, state) {
      final loginLocation = PAGE.signin.path;
      final registerLocation = PAGE.signup.path;
      final homeLocation = PAGE.home.path;
      final splashLocation = PAGE.splash.path;
      final onboardLocation = PAGE.onboarding.path;

      final isLoggedIn = userCubit.state.isLoggedIn;
      final isInitialized = userCubit.state.isInitialized;
      final isOnboarded = userCubit.state.isOnboarded;

      final isInLoginPage = state.subloc == loginLocation;
      final isInInitializePage = state.subloc == splashLocation;
      final isInSignupPage = state.subloc == '$loginLocation/$registerLocation';
      final isInOnboardingPage = state.subloc == onboardLocation;

      if (!isInitialized && !isInInitializePage) {
        return splashLocation;
      }

      if (isInitialized && !isOnboarded && !isInOnboardingPage) {
        return onboardLocation;
      }

      if (isInitialized &&
          isOnboarded &&
          !isLoggedIn &&
          !isInLoginPage &&
          !isInSignupPage) {
        return loginLocation;
      }

      if ((isLoggedIn && isInLoginPage) ||
          (isInitialized && isInInitializePage) ||
          (isOnboarded && isInOnboardingPage)) {
        return homeLocation;
      }

      return null;
    },
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
