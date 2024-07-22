import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gp_east_news/Core/ConstantKeies/ConstKey.dart';
import 'package:gp_east_news/Feature/Fragmetns/saved/data_layer/Provider/savedNewsListProvider.dart';
import 'package:gp_east_news/Feature/News/Data_layer/Models/news_model.dart';

import '../../../../Main/Presentation_layer/views/mainScreen.dart';

class SavedNews {
  final Dio dio;

  SavedNews(this.dio);

  final String base = 'http://${constKey.ip}:${constKey.port}/news';
  final String token = 'Bearer ${user_model.token}';

  Future<String> save(
      {required String userId, required String articalId}) async {
    try {
      Response response = await dio.post(
        '$base/save',
        data: {"userId": userId, "articleId": articalId},
        options: Options(headers: {'Authorization': token}),
      );

      return response.data['message'];
    } on DioException catch (e) {
      log('Error status: ${e.response?.statusCode}');

      log('Error message: ${e.response?.statusMessage}');

      log('Error data: ${e.response?.data}');
      return e.response?.data;
    } catch (e) {
      return 'Something went wrong';
    }
  }

  Future<String> unsave(
      {required String userId, required String articalId}) async {
    try {
      Response response = await dio.post(
        '$base/unsave',
        data: {"userId": userId, "articleId": articalId},
        options: Options(headers: {'Authorization': token}),
      );

      return response.data['message'];
    } on DioException catch (e) {
      log('Error status: ${e.response?.statusCode}');

      log('Error message: ${e.response?.statusMessage}');

      log('Error data: ${e.response?.data}');
      return e.response?.data;
    } catch (e) {
      return 'Something went wrong';
    }
  }


  Future<List<news_model>> getSavedNews({required String userId}) async {
    try {
      Response response = await dio.get(
          '$base/getSaved',
          data: {
            "userId": userId
          },
          options: Options(
              headers: {
                "Authorization": token
              }
          )
      );
      List<dynamic> articles = response.data['articles'];
      List<news_model> savedNews = [];
      for (var article in articles) {
        savedNews.add(news_model(
          id: article['_id'],
          likes: 0,
          comments: 0,
          isLiked: false,
          title: article['title'],
          content: article['content'],
          image: article['imageURL'],),);
      }
    return savedNews;
    } on DioException catch(e){
      log('Error status: ${e.response?.statusCode}');

      log('Error message: ${e.response?.statusMessage}');

      log('Error data: ${e.response?.data}');
      log('$e');
      rethrow;
    }catch(e){
      log('e');
      rethrow;
    }
  }
}
