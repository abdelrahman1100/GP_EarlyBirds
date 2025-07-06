import 'dart:core';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gp_east_news/Core/ConstantKeies/ConstKey.dart';
import 'package:gp_east_news/Feature/Main/Presentation_layer/views/mainScreen.dart';
import 'package:gp_east_news/Feature/News/Data_layer/Models/news_model.dart';


class NewsServieces {
  final Dio dio;

  NewsServieces(this.dio);

  final String url = 'http://${constKey.ip}:${constKey.port}/news/getNews';
  final String token = 'Bearer ${user_model.token}';
  final String country = selectedLang == 'en' ? 'us' :'eg';
  final String lang = selectedLang == 'en' ? 'en' :'ar';

  Future<List<news_model>> getNews({required String categoryName}) async {
    try {
      final response = await dio.get(url,
          data: {
            'country': country,
            'language': lang,
            'category': categoryName,
          },
          options: Options(headers: {'Authorization': token}));
      List<dynamic> respo = response.data;
      List<news_model> articalList = [];
      for (dynamic artical in respo) {
        articalList.add(news_model(
          id:  artical['_id'],
            title: artical['title'],
            image: artical['imageURL'],
            content: artical['content'],
            url:  artical['url'],
            likes: artical['likesCount'],
            comments: artical['commentsCount'],
            isLiked: artical['liked'],
            author: artical['source'],
            date: artical['publishedAt'],
        ),);
      }

      return articalList;
    } on DioException catch (e) {
      log('Dio error $e');
      throw ();
    } catch (e) {
      log('Error fetching mews $e');
      rethrow;
    }
  }
}
