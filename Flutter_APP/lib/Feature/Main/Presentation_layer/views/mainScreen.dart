import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp_east_news/Feature/Main/Presentation_layer/views/widgets/dialog.dart';
import 'package:gp_east_news/Feature/Profile/presentation_layer/views/widgets/userModel.dart';
import 'package:gp_east_news/Feature/Profile/presentation_layer/views/user_profile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../../colors/colors.dart';
import '../../../Fragmetns/home/presentation_layer/views/widgets/app_bar/app_bar.dart';
import '../../../Fragmetns/home/presentation_layer/views/home.dart';
import '../../../Fragmetns/saved/presentation_layer/views/saved_fragment.dart';
import '../../../Fragmetns/settings/presentation_layer/views/setting_fragment.dart';
import '../../../News/Data_layer/Models/news_model.dart';
import 'widgets/bottom_nav_item.dart';

class main_screen extends StatefulWidget {
  main_screen({super.key, required this.current_fragmnet_index});

  int current_fragmnet_index = 0;
  @override
  State<main_screen> createState() => _main_screenState();
}

class _main_screenState extends State<main_screen> {
  late List<news_model> savedNewsList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.current_fragmnet_index;
  }
  List<Widget> body =  [
    const home(),
    saved_fragment(),
    const setting_fragment(),
  ];
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => user_profile(),
                ),
              );
            },
            child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Image.asset('assets/Images/user.png'))),
        backgroundColor: primary_color,
        title: const app_bar(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (_) => const logoutDialog(),
                );
              },

              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),

      body: body.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: primary_color),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        child: SalomonBottomBar(
          backgroundColor: Colors.transparent,
          items: <SalomonBottomBarItem>[
            SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: bottom_nav_item(
                  title: 'home'.tr,
                )),
            SalomonBottomBarItem(
              icon: const Icon(Icons.save),
              title: bottom_nav_item(
                title: 'save'.tr,
              ),
            ),
            SalomonBottomBarItem(
                icon: const Icon(Icons.settings),
                title: bottom_nav_item(
                  title: "settings".tr,
                )),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: primary_color,
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
          curve: Curves.easeInOutCubicEmphasized,
        ),
      ),
    );
  }
}

userModel user_model = userModel(
    userName: 'userName ', Mail: "Mail", password: '', id: '', token: '');

String selectedLang = 'en';

int numberofComments = 0;