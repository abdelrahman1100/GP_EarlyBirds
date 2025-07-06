import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gp_east_news/Core/loading_indecactor%20/data_layer/Dialogs.dart';
import 'package:gp_east_news/Feature/summary/data_layer/summarization.dart';
import 'package:gp_east_news/Feature/summary/presentation_layer/views/summaryView.dart';
import '../../../../../Core/app_rounded_blur.dart';

class summaryIconComponent extends StatelessWidget {
  summaryIconComponent({super.key, required this.content});

  String content;
  String summaryText = 'Summary';

  @override
  Widget build(BuildContext context) {
    return AppRoundedButtonBlur(
      icon: const Icon(
        Icons.summarize,
        color: Colors.white,
      ),
      onTap: () async {
        dialogs().showLodaingDialog(text: 'Summarize', context: context);

        summaryText = await getSummary(Dio()).summary(text: content);
        Navigator.pop(context);
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return summaryView(summaryText: summaryText);
          },
        );
      },
    );
  }
}
