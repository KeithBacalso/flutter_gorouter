import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
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
      //* These 3 routes home, favorites, and profile are in the Root Page bottom nav items.
      //* We used redirect: to them instead of builder: because if we used builder:
      //* it will only navigate the page to its single page not including the bottom nav bar items.
      //* This is also very useful for deeplinking.
      // GoRoute(
      //   path: PAGE.home.path,
      //   redirect: (context, state) => PAGE.home.path,
      // ),
      // GoRoute(
      //   path: PAGE.favorites.path,
      //   redirect: (context, state) => PAGE.home.path,
      // ),
      // GoRoute(
      //   path: PAGE.profile.path,
      //   redirect: (context, state) => PAGE.home.path,
      // ),

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

      final isInitialized = userCubit.state.isInitialized;
      final isLoggedIn = userCubit.state.isLoggedIn;
      final isOnboarded = userCubit.state.isOnboarded;

      final isGoingToInitialize = state.subloc == splashLocation;
      final isGoingToLogin = state.subloc == loginLocation;
      final isGoingToRegister =
          state.subloc == '$loginLocation/$registerLocation';
      final isGoingToOnboard = state.subloc == onboardLocation;

      if (!isInitialized && !isGoingToInitialize) {
        return splashLocation;
      }

      if (isInitialized &&
          !isLoggedIn &&
          !isGoingToLogin &&
          !isGoingToRegister) {
        return loginLocation;
      }

      if (isLoggedIn && !isOnboarded && !isGoingToOnboard) {
        return onboardLocation;
      }

      if ((isLoggedIn && isGoingToLogin) ||
          (isInitialized && isGoingToInitialize) ||
          (isOnboarded && isGoingToOnboard)) {
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
