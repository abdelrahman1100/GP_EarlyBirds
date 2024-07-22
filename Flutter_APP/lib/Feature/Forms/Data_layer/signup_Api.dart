import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gp_east_news/Core/ConstantKeies/ConstKey.dart';
import 'package:gp_east_news/Feature/Main/Presentation_layer/views/mainScreen.dart';



class newUser{
  final Dio dio;

  newUser(this.dio);

  final String url = 'http://${constKey.ip}:${constKey.port}/user/signup';


  Future<String> saveNewUser({required String mail, required String password, required String userName}) async {

    try {
      Response response = await dio.post(
        url,
        data: {
          'email': mail,
          'password' : password,
          'userName' : userName
        },
      );

      SaveUserData(response);

      return 'valid';

    } on DioException catch(e){
      log('Error status: ${e.response?.statusCode}');

      log('Error message: ${e.response?.statusMessage}');

      log('Error data: ${e.response?.data}');
      log('$e');
      return '${e.response?.data}';

    } catch(e){
      log('$e');
      rethrow;
    }
  }


  void SaveUserData(Response<dynamic> response) {
    Map<String,dynamic> userData = response.data;
    user_model.userName = userData['user']['userName'];
    user_model.Mail = userData['user']['email'];
    user_model.id = userData['user']['_id'];
    user_model.token = userData['token'];

  }

}
