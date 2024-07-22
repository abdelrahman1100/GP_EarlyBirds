import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp_east_news/Core/Assets/assets_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../Core/ConstantKeies/ConstKey.dart';
import '../../../../colors/colors.dart';
import '../../../Forms/presentation_layer/SignIn/views/LogIn.dart';
import 'widgets/onboaring_model.dart';

class onboarding_view extends StatefulWidget {
  const onboarding_view({super.key});

  @override
  State<onboarding_view> createState() => _onboarding_viewState();
}

class _onboarding_viewState extends State<onboarding_view> {
  final controller = onboarind_model();
  late final pageController;
  bool isFinalPage = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primary_color,
      body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .9,
              child: PageView.builder(
                itemCount: controller.items.length,
                onPageChanged: (index) => setState(
                  () {
                    isFinalPage = index == controller.items.length - 1;
                  },
                ),
                controller: pageController,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(controller.items[index].image),
                      const SizedBox(height: 48),
                      Text(
                        controller.items[index].title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: kPrimaryFont),
                      ),
                      const SizedBox(height: 48),
                    ],
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: primary_color),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: isFinalPage
                  ? getStartedButtton()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => pageController
                              .jumpToPage(controller.items.length - 1),
                          child:  Text(
                            'Skip'.tr,
                            style: const TextStyle(
                                color: Colors.white, fontFamily: kPrimaryFont),
                          ),
                        ),
                        SmoothPageIndicator(
                          controller: pageController,
                          count: controller.items.length,
                          onDotClicked: (index) => pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeIn),
                          effect: const WormEffect(
                            activeDotColor: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () => pageController.nextPage(
                              duration: const Duration(
                                milliseconds: 600,
                              ),
                              curve: Curves.easeIn),
                          child: const Text(
                            'next',
                            style: TextStyle(
                                color: Colors.white, fontFamily: kPrimaryFont),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
    );
  }

  Widget getStartedButtton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: primary_color,
        borderRadius: BorderRadius.circular(12),
      ),
      width: MediaQuery.of(context).size.width * .9,
      child: GestureDetector(
        onTap: () async {
          final pres = await SharedPreferences.getInstance();
          pres.setBool(constKey.onBoaring, true);
          if (!mounted) return;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const Login()));
        },
        child: AnimatedOpacity(
          opacity: isFinalPage?1.0:0.0,
          duration: const Duration(seconds: 2),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Get start',
                style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
              ),
              Icon(
                Icons.arrow_circle_right,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
