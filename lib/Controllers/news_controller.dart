import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/news_model.dart';

class News {
  List<NewsModel> news = [];
  late bool hasMore;

  Future<List<NewsModel>> getNews() async {
    print("In Controller");
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&sortBy=publishedAt&language=en&apiKey=07dfdd55fd314d12a8eb8b7ef47827ee";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
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
          news.add(newsModel);
        }
      });
    }
    // ignore: avoid_print
    print(news[0].title);
    return news;
  }

  // Future<void> getNewsForCategory(String category) async {
  //   /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
  //   String url =
  //       "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=07dfdd55fd314d12a8eb8b7ef47827ee";

  //   var response = await http.get(Uri.parse(url));

  //   var jsonData = jsonDecode(response.body);

  //   if (jsonData['status'] == "ok") {
  //     jsonData["articles"].forEach((element) {
  //       if (element['urlToImage'] != null && element['description'] != null) {
  //         NewsModel newsModel = NewsModel(
  //           title: element['title'],
  //           // author: element['author'],
  //           // description: element['description'],
  //           // urlToImage: element['urlToImage'],
  //           // publshedAt: DateTime.parse(element['publishedAt']),
  //           // content: element["content"],
  //           // articleUrl: element["url"],
  //         );
  //         news.add(newsModel);
  //       }
  //     });
  //   }
  // }
  // Future<List<NewsModel>> _getExampleServerData(int length) {
  //   return Future.delayed(Duration(seconds: 1), () {
  //     return List<NewsModel>.generate(length, (int index) {
  //       return {
  //         "body": WordPair.random().asPascalCase,
  //         "avatar": 'https://api.adorable.io/avatars/60/${WordPair.random().asPascalCase}.png',
  //       };
  //     });
  //   });
  // }
  // Future<void> loadMore({bool clearCachedData = false}) {
  //   if (clearCachedData) {
  //     _data = [];
  //     hasMore = true;
  //   }
  //   if (_isLoading || !hasMore) {
  //     return Future.value();
  //   }
  //   _isLoading = true;
  //   return _getExampleServerData(10).then((postsData) {
  //     _isLoading = false;
  //     _data.addAll(postsData);
  //     hasMore = (_data.length < 30);
  //     _controller.add(_data);
  //   });
  // }

}
