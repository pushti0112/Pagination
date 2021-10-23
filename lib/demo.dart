import 'package:flutter/material.dart';
import 'package:flutter_pagination_demo/Models/news_model.dart';

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

  Future<bool> getData() async {
    try {
      news = News();
      data = await news.getNews();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getData();
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
          child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: const CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return getListView(context);
                } else {
                  return Container(
                    child: const Text("error"),
                  );
                }
              }),
        ),
      ),
    );
  }

  Widget getListView(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: ((context, index) => Column(
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
                            data[index].title,
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
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                ],
              )),
        ),
        // const Center(
        //   child: CircularProgressIndicator(),
        // )
      ],
    );
  }
}
