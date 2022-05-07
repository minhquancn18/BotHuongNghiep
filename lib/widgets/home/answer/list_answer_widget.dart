// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:huong_nghiep/widgets/home/answer/post_widget.dart';

import '../../../model/posts.dart';
import '../../../resources/firebase_reference.dart';

class ListAnswerWidget extends StatefulWidget {
  const ListAnswerWidget({Key? key}) : super(key: key);

  @override
  State<ListAnswerWidget> createState() => _ListAnswerWidgetState();
}

class _ListAnswerWidgetState extends State<ListAnswerWidget> {
  late Stream<QuerySnapshot> postsStream;
  @override
  void initState() {
    postsStream = postsFR.snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Post> postDocs = [];
    return StreamBuilder(
        stream: postsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }

          snapshot.data!.docs.map((DocumentSnapshot document) {
            Post post = Post.fromSnap(document);
            postDocs.add(post);
          }).toList();

          return Column(children: [
            for (var i = 0; i < postDocs.length; i++) ...[
              PostWidget(post: postDocs[i])
            ]
          ]);
        });
  }
}
