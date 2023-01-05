enum PAGE {
  home,
  splash,
  signin,
  signup,
  onboarding,
  viewItem,
  viewProfile,
  error,
}

extension PageExtension on PAGE {
  String get path {
    switch (this) {
      case PAGE.home:
        return "/";
      case PAGE.splash:
        return "/splash";
      case PAGE.signin:
        return "/signin";
      case PAGE.signup:
        return "/signup";
      case PAGE.onboarding:
        return "/onboarding";
      case PAGE.viewItem:
        return "viewItem";
      case PAGE.viewProfile:
        return "viewProfile";
      case PAGE.error:
        return "/error";
      default:
        return "/";
    }
  }

  String get name {
    switch (this) {
      case PAGE.home:
        return "Home";
      case PAGE.splash:
        return "Splash";
      case PAGE.signin:
        return "Signin";
      case PAGE.signup:
        return "Signup";
      case PAGE.onboarding:
        return "Onboarding";
      case PAGE.viewItem:
        return "ViewItem";
      case PAGE.viewProfile:
        return "ViewProfile";
      case PAGE.error:
        return "Error";
      default:
        return "Home";
    }
  }
}
