import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp_east_news/Core/Messages/toast_message.dart';
import 'package:gp_east_news/Feature/Forms/presentation_layer/signup/views/widgets/have_account.dart';
import 'package:gp_east_news/Feature/category/presentation_layer/views/category_list.dart';
import '../../../../../Core/loading_indecactor /data_layer/Dialogs.dart';
import '../../../../../colors/colors.dart';
import '../../../Data_layer/signup_Api.dart';
import '../../components /Button.dart';
import '../../components /TextComp.dart';
import '../../components /Top_Bar.dart';
import '../../components /TextInputComp.dart';
import '../../components /input_compoenet_model.dart';
import '../../components /password_input.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> globalKey = GlobalKey();
  TextEditingController mailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mailController.dispose();
    userNameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
      ),
      body: SafeArea(
        child: Form(
          key: globalKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Top_Bar(),
                const SizedBox(
                  height: 48,
                ),
                TextComp(
                    message: "let's create account".tr,
                    message_color: Colors.black,
                    size: 16),
                TextInputComp(
                  lableText: 'userName'.tr,
                  sufIcone: Icons.text_fields,
                  controller: userNameController,
                ),
                TextInputComp(
                  lableText: 'email'.tr,
                  sufIcone: Icons.mail,
                  controller: mailController,
                ),
                password_input(
                  model: input_componenet_model(
                      lablText: "password".tr,
                      suffixIcon: Icons.visibility_off,
                      is_password: true),
                  passwordcontroller: passwordController,
                ),
                password_input(
                  model: input_componenet_model(
                      lablText: "confirm password".tr,
                      suffixIcon: Icons.visibility_off,
                      is_password: true),
                  passwordcontroller: confirmPasswordController,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Button(
                    title: 'signup'.tr,
                    backgroundColor: primary_color,
                    onPress: () {
                      FocusScope.of(context).unfocus();
                      if (validateFeildes()) {
                        validToNavigate(context);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 32,),

                const HaveAccount()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void NavigatToConfirmScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) =>  CategoryList()));
  }

  bool ValidateMail({required String mail}) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(mail);
    return emailValid;
  }

  bool isSamePassword(
      {required String password, required String confirmPassword}) {
    return password == confirmPassword;
  }

  bool validateFeildes() {
    if (!globalKey.currentState!.validate()) {
      return false;
    }
    if (!ValidateMail(mail: mailController.text)) {
      ToastMessage().showErrorMessage(message: 'This mail is not valid');
      return false;
    }
    if (!isSamePassword(
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text)) {
      ToastMessage()
          .showErrorMessage(message: 'The Two password are not the same');
      return false;
    }
    return true;
  }

  Future<String> checkStatueResponse() async {
    String code = await newUser(Dio()).saveNewUser(
        mail: mailController.text,
        password: passwordController.text,
        userName: userNameController.text);

    return code;
  }

  void validToNavigate(BuildContext context) async {
    String code = await checkStatueResponse();
    if (code != 'valid') {

      dialogs().ShowErrorDialog(context, code);

    } else {

      dialogs().showLodaingDialog(text: 'Signup', context: context);

      Future.delayed(const Duration(seconds: 5),(){
        Navigator.pop(context);
        NavigatToConfirmScreen(context);
      });
    }
  }

}
