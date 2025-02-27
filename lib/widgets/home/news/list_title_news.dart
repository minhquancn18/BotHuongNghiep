// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/home/detailpage/news_page_screen.dart';
import 'package:huong_nghiep/screens/other/error_screen.dart';

import '../../../models/news.dart';
import '../../../resources/firebase_reference.dart';
import '../../../resources/support_function.dart';
import '../../../utils/styles.dart';

class ListTitleNews extends StatefulWidget {
  final int limited;
  final bool descending;

  const ListTitleNews(
      {Key? key, required this.limited, required this.descending})
      : super(key: key);

  @override
  State<ListTitleNews> createState() => _ListTitleNewsState();
}

class _ListTitleNewsState extends State<ListTitleNews> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> newsStream = widget.limited == 0
        ? newsFR.orderBy('time', descending: widget.descending).snapshots()
        : newsFR
            .orderBy('time', descending: widget.descending)
            .limit(widget.limited)
            .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: newsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
            return ErrorScreen();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitChasingDots(color: Colors.brown, size: 32),
            );
          }

          List<News> newsdocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            News news = News.fromSnap(document);
            newsdocs.add(news);
          }).toList();

          return Column(children: [
            for (var i = 0; i < newsdocs.length; i++) ...[
              GestureDetector(
                  onTap: () {
                    Get.to(NewsPageScreen(newsPostID: newsdocs[i].id!));
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl: newsdocs[i].image!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitHeight,
                              placeholder: (context, _) => SpinKitChasingDots(
                                  color: Colors.brown, size: 32),
                              errorWidget: (context, _, error) =>
                                  Icon(Icons.error),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(getTruncatedTitle(newsdocs[i].title!, 60),
                                    style: kItemText.copyWith(
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 8),
                                Text(
                                  "${newsdocs[i].timeRead!} đọc",
                                  style: kItemText.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  newsdocs[i].time!,
                                  style: kItemText.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      )))
            ]
          ]);
        });
  }
}
