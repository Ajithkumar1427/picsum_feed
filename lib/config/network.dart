import 'package:dio/dio.dart';
import 'globalenv.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(baseUrl: SERVER_URL),
  );

  Future<List<dynamic>> fetchImages(
      int page, int limit) async {
    final response = await dio.get(
      "v2/list",
      queryParameters: {
        "page": page,
        "limit": limit,
      },
    );
    return response.data;
  }
}

final apiService = ApiService();
