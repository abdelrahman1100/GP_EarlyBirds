import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Core/ConstantKeies/ConstKey.dart';
import 'Core/langudages /Translation/translation.dart';
import 'Feature/Splash/presentation_layer/views/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  final onboaring = pref.getBool(constKey.onBoaring) ?? false;
  runApp(MyApp(onBoarding: onboaring));
}

String AppThem = 'light';

class MyApp extends StatelessWidget {
  final bool onBoarding;
  const MyApp({super.key, required this.onBoarding});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: Splashscreen(onboaring: onBoarding),
         translations: Translation(),
         locale:  const Locale('en'),
         fallbackLocale: const Locale('en'),
    );
  }
}
