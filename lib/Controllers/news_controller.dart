import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pagination_demo/Provider/DataProvider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Models/news_model.dart';

class News {
  List<NewsModel> moreNews = [];
  late bool hasMore;
  

  Future<void> getNews(BuildContext context, {bool isRefresh=true,bool isNotify=false}) async {
    DataProvider dataProvider= Provider.of<DataProvider>(context, listen: false);
    try{
     
      if(isRefresh)
      {
        dataProvider.news.clear();
        dataProvider.page=1;
        dataProvider.hasMore=true;
        dataProvider.isFirstTimeLoading=true;
        dataProvider.isLoading = false;
        isNotify=true;

      }
    
      
      if(!dataProvider.hasMore || dataProvider.isLoading) return;
      
      moreNews.clear();
      dataProvider.isLoading=true;
      print("loading "+dataProvider.isLoading.toString());
      if(isNotify) dataProvider.notifyListeners();
      print("In Controller");
      String url = "http://newsapi.org/v2/top-headlines?language=en&page=${dataProvider.page}&apiKey=07dfdd55fd314d12a8eb8b7ef47827ee";
      var response = await http.get(Uri.parse(url));
      var jsonData = jsonDecode(response.body);

      if (jsonData['status'] == "ok") {
        if((jsonData['articles'] as List).isNotEmpty) {
          jsonData["articles"].forEach((element) {
            if (element['urlToImage'] != null && element['description'] != null) {
              NewsModel newsModel = NewsModel(
                title: element['title'],
                // author: element['author'],
                // description: element['description'],
                // urlToImage: element['urlToImage'],
                // publshedAt: DateTime.parse(element['publishedAt']),
                // content: element["content"],
                // articleUrl: element["url"],
              );
              moreNews.add(newsModel);
              
            }
          });
          dataProvider.news.addAll(moreNews);
          dataProvider.page+=1;
          print(dataProvider.page);
        }
        else{
          dataProvider.hasMore=false;
          print("data not found");
        }
      }
      else{
        print("error");
        dataProvider.hasMore=false;
      }

      // ignore: avoid_print
      print(dataProvider.news.length);
      dataProvider.isLoading=false;
      if(dataProvider.isFirstTimeLoading==true)
      {
        dataProvider.isFirstTimeLoading=false;
      }
  

      dataProvider.notifyListeners();
    }
    catch(e){
      dataProvider.isLoading=false;
      dataProvider.news=[];
      dataProvider.hasMore=false;
      dataProvider.isFirstTimeLoading=false;
      dataProvider.page=1;
    }
    
  }


}
