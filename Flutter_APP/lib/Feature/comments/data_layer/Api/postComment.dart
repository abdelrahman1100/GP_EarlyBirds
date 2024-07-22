import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gp_east_news/Core/ConstantKeies/ConstKey.dart';


import '../../../Main/Presentation_layer/views/mainScreen.dart';
import '../model/commentModel.dart';

class postComment {
  final Dio dio;

  postComment(this.dio);

  final String url = 'http://${constKey.ip}:${constKey.port}/comment/addcomment';
  final String token = 'Bearer ${user_model.token}';

  Future<commentModel> post(
      {required String text, required String articleId}) async {
    try {
      Response response = await dio.post(
        url,
        data: {"text": text, "articleID": articleId},
        options: Options(
          headers: {
            'Authorization': token
          }
        )
      );
      dynamic respo = response.data['comment'];
      log('resonse $respo');
      commentModel model = commentModel(id: respo['_id'], text: respo['text'], author:respo['userName'] , authorId: respo['authorID']);
      log('model $model');
      return model;
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