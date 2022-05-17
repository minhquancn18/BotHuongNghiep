// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/jobs.dart';
import '../../../resources/firebase_reference.dart';
import '../../../screens/home/detailpage/jobs_page_screen.dart';

class JobsCarousel extends StatefulWidget {
  const JobsCarousel({Key? key}) : super(key: key);

  @override
  State<JobsCarousel> createState() => _JobsCarouselState();
}

class _JobsCarouselState extends State<JobsCarousel> {
  final _random = Random();
  bool _isFirst = true;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> jobsStream = jobsFR.snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: jobsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          List<Jobs> jobsdocs = [];
          int count = 1;
          snapshot.data!.docs.map((DocumentSnapshot document) {
            if (_isFirst && count < 4) {
              _isFirst = false;
              Jobs jobs = Jobs.fromSnap(document);
              jobsdocs.add(jobs);
              count++;
            } else {
              var number = _random.nextInt(50);
              if (number % 2 == 0) {
                Jobs jobs = Jobs.fromSnap(document);
                jobsdocs.add(jobs);
              }
            }
          }).toList();

          return CarouselSlider(
            options: CarouselOptions(
              height: 250.0,
            ),
            items: jobsdocs.map((jobs) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(JobsPageScreen(jobsPostID: jobs.id!));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(jobs.image!),
                              height: 250,
                              // width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
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
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  jobs.title!,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ))
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        });
  }
}
