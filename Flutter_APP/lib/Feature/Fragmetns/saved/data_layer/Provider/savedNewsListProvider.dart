import 'package:flutter/cupertino.dart';

import '../../../../News/Data_layer/Models/news_model.dart';

class savedNewsListProvider extends ChangeNotifier{
  List<news_model> savedNewsProvider = [];

  void notifieyToRemove({required String articleId}){
    for(var item in savedNewsProvider){
      if(item.id == articleId){
        savedNewsProvider.remove(item);
        return;
      }
    }
  }


}