import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Model_Class/model_class.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<News>?> fatchData() async {
    String API =
        "https://newsapi.org/v2/everything?q=apple&from=2022-02-20&to=2022-02-21&sortBy=popularity&apiKey=ff4b8988543242da8ed51b9b97998214";

    http.Response response = await http.get(Uri.parse(API));

    if (response.statusCode == 200) {
      print(response.statusCode);
      var res = jsonDecode(response.body);
      List data=res["articles"];
      return data.map((e) => News.fromjson(e)).toList();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
        centerTitle: true,
      ),
      body:RefreshIndicator(
        onRefresh:fatchData,
        child: FutureBuilder(
            future: fatchData(),
            builder: (context, shanpshot) {
              if (shanpshot.hasError) {
                return Center(
                  child: Text("${shanpshot.error}"),
                );
              } else if (shanpshot.hasData) {
                List<News>? data = shanpshot.data as List<News>?;
                return RawScrollbar(
                  thumbColor: Colors.pink,
                  child:ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            Image(image: NetworkImage("${data?[i].urlToImage}")
                            ),
                            Text("${data?[i].content}"),
                            Text("${data?[i].publishedAt}")
                          ],
                        );
                      }),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
