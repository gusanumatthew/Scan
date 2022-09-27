import 'package:alome/src/core/routes.dart';
import 'package:alome/src/features/authentication/states/login_state.dart';
import 'package:alome/src/repositories/authentication_repository.dart';
import 'package:alome/src/repositories/user_repository.dart';
import 'package:alome/src/services/failure.dart';
import 'package:alome/src/services/navigation_service.dart';
import 'package:alome/src/services/snackbar_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  Reader reader;
  LoginNotifier(this.reader) : super(LoginState());
  void passwordVisibility() {
    state = state.copyWith(obscureText: !state.obscureText);
  }

  void checkIsLoading() {
    state = state.copyWith(isLoading: !state.isLoading);
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      await reader(authenticationRepository).login(
        email: email,
        password: password,
      );

      final user = reader(authenticationRepository).currentUser;
      final appUser = await reader(userRepository).getFutureUser(user!.uid);
      reader(navigationService)
          .navigateOffNamed(Routes.alome, arguments: appUser);
    } on Failure catch (ex) {
      reader(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  User get user => reader(authenticationRepository).currentUser!;

  Future<void> logoutUser() async {
    await reader(authenticationRepository).signOut();

    reader(navigationService).navigateOffAllNamed(
      Routes.login,
      (_) => false,
    );
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
    (ref) => LoginNotifier(ref.read));
