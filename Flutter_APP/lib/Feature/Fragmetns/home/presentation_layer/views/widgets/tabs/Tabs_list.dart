import 'package:flutter/src/material/tabs.dart';
import 'widgets/tap_item.dart';

class TabsList{
  static List<Tab> list = [
    Tab(
      child: tap_item(
        title: "all",
      ),
    ),
    Tab(
      child: tap_item(
        title: "sports",
      ),
    ),
    Tab(
      child: tap_item(
        title: "business",
      ),
    ),
    Tab(
      child: tap_item(
        title: "science",
      ),
    ),
    Tab(
      child: tap_item(
        title: "technology",
      ),
    ),
    Tab(
      child: tap_item(
        title: "entertainment",
      ),
    ),
    Tab(
      child: tap_item(
        title: "health",
      ),
    ),
  ];
}