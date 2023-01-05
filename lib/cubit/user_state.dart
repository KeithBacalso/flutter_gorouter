part of 'user_cubit.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    @Default(false) bool isInitialized,
    @Default(false) bool isOnboarded,
    @Default(false) bool isLoggedIn,
  }) = _UserState;
}
