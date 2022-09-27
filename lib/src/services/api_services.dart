import 'package:alome/src/services/api_key.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  final String baseUrl = "https://app.covve.com/api/businesscards/scan";

  // register
  Future<StreamedResponse> scanRequest({required String imagePath}) async {
    var url = baseUrl;
    var head = {
      'Authorization': ApiKeys.scanApiKey,
      'Content-Type': 'multipart/form-data',
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', imagePath));
    request.headers.addAll(head);
    return request.send();
  }
}

final apiProvider = Provider((ref) => ApiService());
