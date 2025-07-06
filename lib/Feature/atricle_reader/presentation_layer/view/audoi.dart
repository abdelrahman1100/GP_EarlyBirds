
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gp_east_news/Core/app_rounded_blur.dart';
import 'package:gp_east_news/Feature/News/Data_layer/Models/news_model.dart';
import 'package:gp_east_news/Feature/atricle_reader/presentation_layer/view/widgets/audioView.dart';


class AudoiIcon extends StatefulWidget {
   AudoiIcon({super.key, required this.model});
  news_model model;
  @override
  State<AudoiIcon> createState() => _AudoiIconState();
}

class _AudoiIconState extends State<AudoiIcon> {


  @override
  Widget build(BuildContext context) {
    return AppRoundedButtonBlur(
      onTap: (){
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) =>  audioView(content: widget.model.content!,)
        );
      },
      icon: const Icon(
        Icons.audio_file,
        color: Colors.white,
      ),
    );
  }
}
