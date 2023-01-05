enum PAGE {
  home(path: '/', name: 'Home'),
  signin(path: '/signin', name: 'Signin'),
  signup(path: 'signup', name: 'Signup'),
  onboarding(path: '/onboarding', name: 'Onboarding'),
  viewItem(path: 'viewItem', name: 'ViewItem'),
  viewProfile(path: 'viewProfile', name: 'ViewProfile'),
  error(path: '/error', name: 'Error');

  final String path;
  final String name;
  
  const PAGE({required this.path, required this.name});
}
