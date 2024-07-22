import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gp_east_news/Core/ConstantKeies/ConstKey.dart';
import 'package:gp_east_news/Core/langudages%20/ar.dart';
import 'package:gp_east_news/Feature/interactions%20/data_layer/Api/likesModel.dart';
import '../../../Main/Presentation_layer/views/mainScreen.dart';
import 'likedpostmodel.dart';

class Likes {
  final Dio dio;

  Likes(this.dio);

  final String url = 'http://${constKey.ip}:${constKey.port}/like/getlikes';
  final String urlPost = 'http://${constKey.ip}:${constKey.port}/like/like';
  final String token = 'Bearer ${user_model.token}';

  Future<likesModel> getLiks({required String articleId}) async {
    try {
      Response response = await dio.get(
        url,
        data: {
          "articleID": articleId
        },
        options: Options(headers: {'Authorization': token},),
      );
      int likesCount = response.data['Likes_count'];
      List<dynamic> all = response.data['all'];
      List<String> articles = [];
      List<String> author = [];
      for (var item in all) {
        articles.add(item['articleID']);
        author.add(item['authorID']);
      }
      likesModel model = likesModel(
          likes: likesCount, articleID: articles, authoerID: author);
      return model;
    } on DioException catch (e) {
      log('Error status: ${e.response?.statusCode}');

      log('Error message: ${e.response?.statusMessage}');

      log('Error data: ${e.response?.data}');
      return e.response?.data;
    } catch (e) {
      log("some thing went wrong: $e");
      rethrow;
    }
  }


  Future<likesPostModel> postLike({required String articleID}) async {
    try {
      Response response = await dio.post(
        urlPost,
        data: {
          "articleID": articleID,
        },
        options: Options(headers: {'Authorization': token},),
      );
      likesPostModel model = likesPostModel(likes: response.data['Likes_count'],statue: response.data['status']);
      return model;
    }on DioException catch (e) {
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