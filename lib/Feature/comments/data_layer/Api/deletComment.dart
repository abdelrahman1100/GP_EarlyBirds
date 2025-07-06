import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gp_east_news/Core/ConstantKeies/ConstKey.dart';

import '../../../Main/Presentation_layer/views/mainScreen.dart';

class DeleteComment{
  final Dio dio;
  DeleteComment(this.dio);
  final String url = 'http://${constKey.ip}:${constKey.port}/comment/deletecomment';
  final String token = 'Bearer ${user_model.token}';
  Future<bool> delete({required String authorId, required String commentId})async{
    try{
      Response response = await dio.delete(
        url,
        data: {
          "authorID" : authorId,
          "commentID" : commentId,
        },
          options: Options(
              headers: {
                'Authorization': token
              }
          )
      );

      log('response: ${response.data}');
      bool operation = response.data['result']['acknowledged'];
      return operation;
    }
    on DioException catch (e) {
      log('Error status: ${e.response?.statusCode}');

      log('Error message: ${e.response?.statusMessage}');

      log('Error data: ${e.response?.data}');
      return e.response?.data;
    } catch (e) {
      log("some thing went wrong: $e");
      rethrow;
    }
  }
}