import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final model = ChangeNotifierProvider.autoDispose<Model>((ref) => Model());

class Model extends ChangeNotifier {
  Dio dio = Dio();
  Logger logger = Logger();
  String accessKey = dotenv.env["Access_Key"]!;
  List<String> photoUrls = [];
  List descriptions = [];
  List likes = [];
  Future<void> fetchImages(String query) async {
    try {
      Response response = await dio
          .get("https://api.unsplash.com/search/photos", queryParameters: {
        'client_id': accessKey,
        'query': query,
        'per_page': 30,
        'page': 1,
      });
      photoUrls = response.data['results']
          .map<String>((photo) => photo['urls']['regular'] as String)
          .toList();

      descriptions = response.data['results']
      .map((photo) => photo['description']).toList();

      likes = response.data['results']
          .map((photo) => photo['likes']).toList();

      logger.d(photoUrls);
      logger.d(descriptions);
      logger.d(likes);
    } catch (error) {
      logger.e("Error $error");
    }
    notifyListeners();
  }
}
