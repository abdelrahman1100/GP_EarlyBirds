import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_east_news/Feature/Splash/presentation_layer/views/widgets/logoAnimation.dart';
import 'package:gp_east_news/colors/colors.dart';
import '../../../Forms/presentation_layer/SignIn/views/LogIn.dart';
import '../../../on_boarding/presentation_layer/views/onboarding_view.dart';

class Splashscreen extends StatefulWidget {
  Splashscreen({super.key, required this.onboaring});

  bool onboaring;

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

late AnimationController animationController;
late Animation<Offset> Sliding;

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SlidingAnimation();
    NavigateToMainScreen();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff03416E),
        body: logoAnimation(
          Sliding: Sliding,
        ));
  }



  void NavigateToMainScreen() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) =>
                widget.onboaring ? const Login() : const onboarding_view()));
      },
    );
  }

  void SlidingAnimation() {
    animationController = AnimationController(vsync: this, duration: kDuration);
    Sliding = Tween(begin: const Offset(0, 3), end: Offset.zero)
        .animate(animationController);
    animationController.forward();
  }
}
