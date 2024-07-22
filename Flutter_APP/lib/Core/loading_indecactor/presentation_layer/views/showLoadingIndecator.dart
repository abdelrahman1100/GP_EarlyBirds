import 'package:flutter/material.dart';
import 'package:gp_east_news/Core/loading_indecactor%20/presentation_layer/views/widgets/getHeadingText.dart';
import 'package:gp_east_news/Core/loading_indecactor%20/presentation_layer/views/widgets/getText.dart';
import 'package:gp_east_news/Core/loading_indecactor%20/presentation_layer/views/widgets/loading_indicator.dart';


class showLoadingIndecator extends StatelessWidget {
  showLoadingIndecator({super.key, required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.black87.withOpacity(0.8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const getLoadingIndicator(),
          const getHeadingText(),
          getText(
            text: text,
          )
        ],
      ),
    );
  }
}
