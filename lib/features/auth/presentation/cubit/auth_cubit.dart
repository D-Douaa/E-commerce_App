
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasource/loginservice.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginService _loginService;

  AuthCubit({LoginService? loginService})
      : _loginService = loginService ?? LoginService(),
        super(AuthInitial());

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await _loginService.loginUser(
        username: username,
        password: password,
      );

      emit(AuthSuccess());
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }
}
