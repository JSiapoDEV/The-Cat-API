import 'dart:developer';

import 'package:tca/config.dart';
import 'package:tca/model/bread.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class ApiService {
  static const String apiUrl = '$API/breeds';

  Future<List<CatBreed>> fetchItems(int page, int limit) async {
    try {
      final response = await dio.get<List<dynamic>>(apiUrl,
          queryParameters: {'page': page, 'limit': limit});

      log("page: $page");
      // print('response: $response');
      if (response.statusCode == 200) {
        var data = response.data;
        // print('data: $data');
        if (data == null) {
          return [];
        }
        // data.map((item) => print(item)).toList();
        // return [];
        return data.map((item) => CatBreed.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load items1');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Failed to load items2');
    }
  }
}
