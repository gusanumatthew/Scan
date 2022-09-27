import 'package:alome/src/features/home/models/scan_model.dart';

class ScanState {
  final bool isLoading;
  ScanModel? scanModel;
  ScanState({
    this.isLoading = false,
    this.scanModel,
  });

  ScanState copyWith({bool? isLoading, ScanModel? scanModel}) {
    return ScanState(
        isLoading: isLoading ?? this.isLoading,
        scanModel: scanModel ?? this.scanModel);
  }
}
