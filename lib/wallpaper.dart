import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pexels_wallpaper/full_screen.dart';

class WallPaper extends StatefulWidget {
  const WallPaper({super.key});

  @override
  State<WallPaper> createState() => _WallPaperState();
}

class _WallPaperState extends State<WallPaper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchapi();
  }

  List images = [];
  int page = 1;

  fetchapi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
              'Db2BTp4kqFvZ77IobOyvbWP3MfuC0LgNeIk49J7KoziJRmDyzrc9kS3J'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      print(images[0]);
    });
  }

  loadmore() async {
    setState(() {
      page = page + 1;
    });
    String url =
        'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          'Db2BTp4kqFvZ77IobOyvbWP3MfuC0LgNeIk49J7KoziJRmDyzrc9kS3J'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: GridView.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 2,
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 2),
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    child: InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => FullScreen(imageUrl: images[index]['src']['tiny'].toString()))));
                      },
                      child: Image.network(
                        images[index]['src']['small'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
          )),
          InkWell(
            onTap: () {
              loadmore();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              child: const Center(child: Text('Load More..')),
            ),
          ),
        ],
      ),
    );
  }
}
