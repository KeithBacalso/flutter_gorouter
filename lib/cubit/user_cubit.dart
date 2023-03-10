import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../hive/hive_box.dart';
import '../hive/user/user_hive.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  //* If you are not using the class generator from Hive, you can do all the commented
  //* codes below(including the commented codes in the methods).
  // final _onboardBox = Hive.box('onboard');
  // final _loginBox = Hive.box('login');

  final _userBox = HiveBox.getUser();

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(
      isInitialized: true,
      isLoggedIn: _userBox.get('isLoggedIn')?.isLoggedIn ?? false,
      isOnboarded: _userBox.get('isOnboarded')?.isOnboarded ?? false,
    ));
  }

  void onboard() {
    //* UserHive is in each of the methods login and logout too.
    //* This is because if we only have one instance above, Hive will give error.
    final userHive = UserHive(isOnboarded: true);
    _userBox.put('isOnboarded', userHive);

    // _userBox.put('isOnboard', _userHive);
    emit(state.copyWith(isOnboarded: true));
  }

  void login() {
    final userHive = UserHive(isLoggedIn: true);
    _userBox.put('isLoggedIn', userHive);

    // _loginBox.put('isLoggedIn', true);
    emit(state.copyWith(isLoggedIn: true));
  }

  void logout() {
    final userHive = UserHive(isLoggedIn: false);
    _userBox.put('isLoggedIn', userHive);

    // _loginBox.put('isLoggedIn', false);
    emit(state.copyWith(isLoggedIn: false));
  }
}
