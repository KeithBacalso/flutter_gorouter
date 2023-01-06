enum PAGE {
  home(
    path: '/',
    name: 'Home',
  ),
  splash(
    path: '/splash',
    name: 'Splash',
  ),
  signin(
    path: '/signin',
    name: 'Signin',
  ),
  signup(
    path: 'signup',
    name: 'Signup',
  ),
  onboarding(
    path: '/onboarding',
    name: 'Onboarding',
  ),
  viewItem(
    path: 'viewItem',
    name: 'ViewItem',
  ),
  favorites(
    path: '/favorites',
    name: 'Favorites',
  ),
  profile(
    path: '/profile',
    name: 'Profile',
  ),
  error(
    path: '/error',
    name: 'Error',
  );

  final String path;
  final String name;

  const PAGE({required this.path, required this.name});
}
