// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/news/news.dart';
import '../../../utils/styles.dart';

class NewsPageScreen extends StatelessWidget {
  final News newsPost;
  const NewsPageScreen({Key? key, required this.newsPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
          width: size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black54
                      ]).createShader(
                      Rect.fromLTRB(0, -140, rect.width, rect.height * 0.8));
                },
                blendMode: BlendMode.darken,
                child: ClipRRect(
                    child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(newsPost.image),
                        height: size.height,
                        width: size.width)),
              ),
              Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [
                      Color(0xCC000000),
                      Color(0x00000000),
                      Color(0x00000000),
                      Color(0xCC000000),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(top: 30, left: 10),
                    child: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                // alignment: Alignment.bottomCenter,
                child: Container(
                  width: size.width,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        newsPost.title,
                        style: kTitle,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(newsPost.sourceImage))),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    newsPost.source,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    newsPost.time,
                                    style: TextStyle(color: Colors.grey[400]),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 40),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.bookmark_outlined,
                                      color: Colors.white, size: 30),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.share,
                                      color: Colors.white, size: 30),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, right: 40),
                        height: 3,
                        decoration: BoxDecoration(color: Colors.white),
                      ),
                      Scrollbar(
                        child: Container(
                          margin: EdgeInsets.only(top: 10, right: 40),
                          child: Text(newsPost.description,
                              style: kDescription,
                              textAlign: TextAlign.justify),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
