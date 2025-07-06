import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../Main/Presentation_layer/views/mainScreen.dart';

class reader {
  final Dio dio;

  reader(this.dio);

  final String url = "http://192.168.1.60:2000/reader/readNews";
  final String token = 'Bearer ${user_model.token}';

  Future<void> getAudio({required String text}) async {
    try {
      Response response = await dio.get(url,
          data: {
            'text': text,
          },
          options: Options(headers: {'Authorization': token}));
      log("Date for reader: ${response.data}");
    } on DioException catch (e) {
      log('Error status: ${e.response?.statusCode}');

      log('Error message: ${e.response?.statusMessage}');

      log('Error data: ${e.response?.data}');
      return e.response?.data;
    } catch (e) {
      log("some thing went wrong: $e");
    }
  }
}
