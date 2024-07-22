import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gp_east_news/Core/ConstantKeies/ConstKey.dart';

import '../../../Main/Presentation_layer/views/mainScreen.dart';
import '../model/commentModel.dart';

 class Comments {
  final Dio dio;

  Comments(this.dio);

  final String url = 'http://${constKey.ip}:${constKey.port}/comment/getcomment';
  final String token = 'Bearer ${user_model.token}';

  Future getComment({required String articleId}) async {
    try {
      Response response = await dio.get(
        url,
        data: {"articleID": articleId},
        options: Options(
          headers: {'Authorization': token},
        ),
      );
      List<dynamic> respo = response.data['comment'];
      List<commentModel> comments = [];
      for (var comment in respo) {
        if (!comment.containsKey('userName')) continue;
        comments.add(
          commentModel(
            id: comment['_id'],
            text: comment['text'],
            author: comment['userName'],
            authorId: comment['authorID'],
          ),
        );
      }
      return comments;
    }
    on DioException catch (e) {
      log('Error status: ${e.response?.statusCode}');

      log('Error message: ${e.response?.statusMessage}');

      log('Error data: ${e.response?.data}');
      return e.response?.data;
    } catch (e) {
      log("some thing went wrong: $e");
    }
  }

}


