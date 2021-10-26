// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_pagination_demo/Models/news_model.dart';

class DataProvider extends ChangeNotifier{

  int page=1;
  
  bool hasMore = true, isLoading = false, isFirstTimeLoading = true;

  List<NewsModel> news=[];


}