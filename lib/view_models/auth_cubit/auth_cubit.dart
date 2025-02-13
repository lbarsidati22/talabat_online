import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/services/auth_services.dart';
import 'package:talabat_online/view_models/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final authServices = AuthServicesEmpl();

  Future<void> loginWithWmailAndPaasword(String email, String password) async {
    emit(AuthLoadoing());
    try {
      final result =
          await authServices.loginWithEmailAndPassword(email, password);
      if (result) {
        emit(AuthDone());
      } else {
        emit(AuthError('login is failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    AuthLoadoing();
    try {
      final result =
          await authServices.registerWithEmailAndPassword(email, password);
      if (result) {
        emit(AuthDone());
      } else {
        emit(AuthError('Register Failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void checkAuth() async {
    final user = authServices.currentUser();
    if (user != null) {
      emit(AuthDone());
    }
  }

  Future<void> logOut() async {
    emit(AuthLogingOut());
    try {
      await authServices.logOut();
      emit(AuthLogedOut());
    } catch (e) {
      emit(AuthLogedOutError(e.toString()));
    }
  }
}
