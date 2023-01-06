import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  final _onboardBox = Hive.box('onboard');
  final _loginBox = Hive.box('login');

  Future<void> initialize() async {
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(
      isInitialized: true,
      isOnboarded: _onboardBox.get('isOnboard') ?? false,
      isLoggedIn: _loginBox.get('isLoggedIn') ?? false
    ));
  }

  void onboard() {
    _onboardBox.put('isOnboard', true);
    emit(state.copyWith(isOnboarded: true));
  }

  void login() {
    _loginBox.put('isLoggedIn', true);
    emit(state.copyWith(isLoggedIn: true));
  }

  void logout() {
    _loginBox.put('isLoggedIn', false);
    emit(state.copyWith(isLoggedIn: false));
  }
}
