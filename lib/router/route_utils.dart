enum PAGE {
  root(
    path: '/',
    name: 'Root',
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
  home(
    path: '/home',
    name: 'Home',
  ),
  viewItem(
    path: 'viewItem/:id',
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
