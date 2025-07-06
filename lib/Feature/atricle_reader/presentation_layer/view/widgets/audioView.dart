import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:gp_east_news/colors/colors.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../../../Core/Assets/assets_data.dart';

class audioView extends StatefulWidget {
  audioView({super.key, required this.content});
  final List<String> _list = ['0.5','1.0','1.5','2.0'];
  String content;

  @override
  State<audioView> createState() => _audioViewState();
}

class _audioViewState extends State<audioView> {
  FlutterTts flutterTts = FlutterTts();
  Icon current = const Icon(Icons.play_arrow,color:Colors.white,);
  bool _isPlaying = true;
  double speed = 0.5;
  int currentIndex = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTTs();
  }

  initTTs() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(speed);
    await flutterTts.setPitch(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height:50,
            width: 1500,
            child: ToggleSwitch(
              minHeight:100,
              minWidth: 1500,
              fontSize: 12,
              activeBgColor:[primary_color],
              initialLabelIndex: currentIndex,
              totalSwitches: 4,
              labels:widget._list,
              changeOnTap: true,
              onToggle: (index) async{
                setState(() {
                  ChangeVoiceSpeed(index);
                  currentIndex = index!;
                  flutterTts.setSpeechRate(speed);
                  flutterTts.pause();
                  _isPlaying = false;
                });
              },
              animate: true,
              animationDuration: 300,
              textDirectionRTL: true,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              color: primary_color
            ),
            child: IconButton(
                onPressed: () async {
                  setState(() {
                    current =
                        _isPlaying ? const Icon(Icons.pause,color: Colors.white,) : const Icon(Icons.play_arrow,color: Colors.white,);
                    _isPlaying = !_isPlaying;
                  });
                  await changeStat();
                },
                icon: current),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () async {
              await flutterTts.stop();
              Navigator.pop(context);
            },
            child: Text(
              'close'.tr,
              style: const TextStyle(
                  color: Colors.black, fontFamily: kPrimaryFont),
            ))
      ],
      title: Text(
        "textReader".tr,
        style: const TextStyle(color: Colors.black, fontFamily: kPrimaryFont),
      ),
    );
  }

  void ChangeVoiceSpeed(int? index) {
    switch (index) {
      case 0:
        {
          speed = 0.25;
          break;
        }
      case 1:
        {
          speed = 0.5;
          break;
        }
      case 2:
        {
          speed = 1.0;
          break;
        }
      case 3:
        {
          speed = 1.5;
          break;
        }
    }
  }

  Future<void> changeStat() async {
    if (_isPlaying == true) {
      await flutterTts.pause();
    } else {
      await flutterTts.speak(widget.content);
    }
  }
}
