import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState.unauthenticated());

  void login() {
    emit(const LoginState.authenticated(status: AuthStatus.authenticated));
  }

  void logout() {
    emit(const LoginState.unauthenticated(status: AuthStatus.unauthenticated));
  }
}
