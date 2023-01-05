part of 'login_cubit.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

@freezed
class LoginState with _$LoginState {
  const factory LoginState.authenticated(
      {@Default(AuthStatus.unknown) AuthStatus status}) = Authenticated;
  const factory LoginState.unauthenticated(
      {@Default(AuthStatus.unknown) AuthStatus status}) = Unauthenticated;
}
