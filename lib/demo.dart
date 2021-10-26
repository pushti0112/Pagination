import 'package:flutter/material.dart';
import 'package:flutter_pagination_demo/Models/news_model.dart';
import 'package:flutter_pagination_demo/Provider/DataProvider.dart';
import 'package:provider/provider.dart';

import 'Controllers/news_controller.dart';

class Pagination extends StatefulWidget {
  const Pagination({Key? key}) : super(key: key);

  @override
  _PaginationState createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  late News news;
  List<NewsModel> data = [];
  late Future<bool> _future;
//  late DataProvider dataProvider;

  // Future<bool> getData(BuildContext context) async {
  //   try {
  
  //     await news.getNews(context);
  
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("in init");
    _future=Future.value(false);
    news = News();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async{

      //  _future =  getData(context);
      //   print(_future);
      //   setState(() {
          
      //   });
      await news.getNews(context);
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child:
           Provider.of<DataProvider>(context,listen: true).isFirstTimeLoading 
            ? Center(child: const CircularProgressIndicator())
            :  getListView(context),

          // FutureBuilder(
          //     future: _future,
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return Center(child: const CircularProgressIndicator());
          //       } 
          //       else if (snapshot.connectionState == ConnectionState.done) {
          //         return getListView(context);
          //       } 
          //       else {
          //         return Container(
          //           child: const Text("error"),
          //         );
          //       }
          //     }),
        ),
      ),
    );
  }

  Widget getListView(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (BuildContext context, DataProvider dataProvider, Widget? child) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
               // scrollDirection: Axis.vertical,
                itemCount: dataProvider.news.length,
                itemBuilder: ((context, index) {
                  if((index+1)==dataProvider.news.length && dataProvider.hasMore) {
                    news.getNews(context,isRefresh: false);
                    // dataProvider.isLoading=true;
                    // print("loading"+dataProvider.isLoading.toString());
                  }
                  return Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[400]),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(index.toString()),
                          const SizedBox(
                            width: 4,
                          ),
                          Flexible(
                            child: Text(
                              dataProvider.news[index].title,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    if((index+1)!=dataProvider.news.length)
                    Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    SizedBox(height: 8,),
                    
                    if((index+1)==dataProvider.news.length  &&  dataProvider.isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    ),                  
                    SizedBox(height: 8,),
                  ],
                );
                } 
                 ),
              ),
              
            ),
            
          ],
        );
      }
    );
  }
}
