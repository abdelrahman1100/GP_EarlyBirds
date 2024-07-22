import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gp_east_news/Core/ConstantKeies/ConstKey.dart';

import '../../Main/Presentation_layer/views/mainScreen.dart';

class getSummary {
  final Dio dio;

  getSummary(this.dio);

  final String url = 'http://${constKey.ip}:${constKey.port}/news/summarize';
  final String token = 'Bearer ${user_model.token}';

  Future<String> summary({required String text}) async {
    try {
      Response response = await dio.post(url, data: {
        'text': text
      }, options: Options(headers: {'Authorization': token},),);
      String summaryText = response.data['summary'];
      return summaryText;

    } on DioException catch(e){
      log('Error status: ${e.response?.statusCode}');

      log('Error message: ${e.response?.statusMessage}');

      log('Error data: ${e.response?.data}');
      return e.response?.data;
    } catch(e){
      return 'Some thing went wrong';
    }
  }
}