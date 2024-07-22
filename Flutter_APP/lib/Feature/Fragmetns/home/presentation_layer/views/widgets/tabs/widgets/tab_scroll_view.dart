import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../colors/colors.dart';
import '../Tabs_list.dart';

class tabScrollView extends StatelessWidget {
  const tabScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
        tabAlignment: TabAlignment.center,
        isScrollable: true,
        dividerColor: Colors.transparent,
        indicatorColor: primary_color,
        unselectedLabelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: primary_color,
        tabs: TabsList.list,
    );
  }
}
