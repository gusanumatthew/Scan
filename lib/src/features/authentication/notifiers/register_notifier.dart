import 'package:alome/src/core/routes.dart';
import 'package:alome/src/features/authentication/states/register_state.dart';
import 'package:alome/src/repositories/authentication_repository.dart';
import 'package:alome/src/services/failure.dart';
import 'package:alome/src/services/navigation_service.dart';
import 'package:alome/src/services/snackbar_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterNotifier extends StateNotifier<RegisterState> {
  Reader reader;
  RegisterNotifier(this.reader) : super(RegisterState());
  void passwordVisibility() {
    state = state.copyWith(obscureText: !state.obscureText);
  }

  void checkIsLoading() {
    state = state.copyWith(isLoading: !state.isLoading);
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String displayName,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      await reader(authenticationRepository).registerRepository(
          email: email, displayName: displayName, password: password);
      reader(snackbarService)
          .showSuccessSnackBar('Account Successfully created');
      reader(navigationService).navigateOffAllNamed(Routes.login, (_) => false);
    } on Failure catch (ex) {
      reader(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  // void navigateToLogin() => reader(navigationService).navigateBack();
}

final registerProvider = StateNotifierProvider<RegisterNotifier, RegisterState>(
    (ref) => RegisterNotifier(ref.read));
