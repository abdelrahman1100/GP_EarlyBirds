import 'package:flutter/cupertino.dart';

class logoAnimation extends StatelessWidget {
  logoAnimation({super.key, required this.Sliding});

  Animation<Offset> Sliding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        builder: (context, _) {
          return SlideTransition(
            position: Sliding,
            child: Image.asset(
              'assets/logo/logo128.png',
            ),
          );
        },
        animation: Sliding,
      ),
    );
  }
}
