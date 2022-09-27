import 'package:alome/src/features/home/models/scan_model.dart';
import 'package:alome/src/features/home/states/home_state.dart';
import 'package:alome/src/services/api_services.dart';
import 'package:alome/src/services/failure.dart';
import 'package:alome/src/services/snackbar_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScanNotifier extends StateNotifier<ScanState> {
  Reader reader;
  ScanNotifier(this.reader) : super(ScanState());

  void checkIsLoading() {
    state = state.copyWith(isLoading: !state.isLoading);
  }

  Future<void> scanCard({
    required String imageFile,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final response =
          await reader(apiProvider).scanRequest(imagePath: imageFile);
      if (response.statusCode == 200) {
        final scanModel =
            scanModelFromJson(await response.stream.bytesToString());
        state = state.copyWith(
          isLoading: false,
          scanModel: scanModel,
        );
        reader(snackbarService).showSuccessSnackBar('Card Scanned Succesfully');
      }
    } on Failure catch (ex) {
      reader(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final scanProvider = StateNotifierProvider<ScanNotifier, ScanState>(
    (ref) => ScanNotifier(ref.read));
