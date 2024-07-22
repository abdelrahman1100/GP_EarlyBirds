import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gp_east_news/Core/ConstantKeies/ConstKey.dart';
import 'package:gp_east_news/Feature/Main/Presentation_layer/views/mainScreen.dart';

class Validation {
  final Dio dio;

  Validation(this.dio);

  final String url = 'http://${constKey.ip}:${constKey.port}/user/login';

  Future<int> isUserFound(
      {required String mail, required String password}) async {
    try {
      Response response = await dio.post(
        url,
        data: {'email': mail, 'password': password},
      );

      SaveUserData(response);

      return 200;
    } on DioException catch (e) {
      log('Error status: ${e.response?.statusCode}');

      log('Error message: ${e.response?.statusMessage}');

      log('Error data: ${e.response?.data}');

      log('$e');
      return 400;
    } catch (e) {
      log('$e');
      rethrow;
    }
  }

  void SaveUserData(Response<dynamic> response) {
    Map<String, dynamic> userData = response.data;
    user_model.userName = userData['user']['userName'];
    user_model.password = userData['user']['password'];
    user_model.Mail = userData['user']['email'];
    user_model.id = userData['user']['_id'];
    user_model.token = userData['token'];
    log("user id: ${user_model.id}");
    log("user token: ${user_model.token}");
  }
}
