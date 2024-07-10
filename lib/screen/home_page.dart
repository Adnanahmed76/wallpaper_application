import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_application/screen/fullscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //list for use wallpaper
  List images = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    fetchapi();
  }

  fetchapi() async {
    await http.get(
      Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
      headers: {
        'Authorization': 'oG2qux00Cs2gBb31fi8XYa0C2ZK4kHQglj1fSm2WEsZfh8bKYUmiBCtm'
      },
    ).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      print(images);
    });
  }

  Loadmore() async {
    setState(() {
      page = page + 1;
    });
    String url = "https://api.pexels.com/v1/curated?per_page=80&page=" + page.toString();
    await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'oG2qux00Cs2gBb31fi8XYa0C2ZK4kHQglj1fSm2WEsZfh8bKYUmiBCtm'
      },
    ).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  Future<bool> _onWillPop() async {
    return true; // Returning true will allow the app to close
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: GridView.builder(
                    itemCount: images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      childAspectRatio: 2 / 3,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Fullscreen(imageUrl: images[index]?['src']['large2x']),
                            ),
                          );
                        },
                        child: Container(
                          child: Image.network(
                            images[index]?['src']['tiny'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Loadmore();
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      "Load More",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
