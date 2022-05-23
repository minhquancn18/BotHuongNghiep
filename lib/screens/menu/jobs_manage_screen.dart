// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../utils/constants.dart';
import '../../utils/styles.dart';
import '../../widgets/home/manage/jobs_manage_body.dart';
import '../home/manage/add_jobs_screen.dart';

class JobsManageScreen extends StatefulWidget {
  const JobsManageScreen({Key? key}) : super(key: key);

  @override
  _JobsManageScreenState createState() => _JobsManageScreenState();
}

class _JobsManageScreenState extends State<JobsManageScreen> {
  bool descending = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xffBFBFBF),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(top: 10, left: 10, bottom: 5),
            child: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Quản lý bài đăng".capitalize!,
            style: kDefaultTextStyle.copyWith(
                fontSize: 24, color: Color.fromARGB(255, 142, 142, 142)),
            textAlign: TextAlign.center),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                descending = !descending;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.1,
              decoration: BoxDecoration(
                  color: Color(0xffBFBFBF),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 10, bottom: 5),
              child: Icon(MdiIcons.sort),
            ),
          ),
          horizontalSpaceSmall
        ],
      ),
      extendBodyBehindAppBar: true,
      body: JobsManageBody(descending: descending),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Get.to(AddJobsScreen());
            if (result != null) {
              setState(() {});
            }
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xffBFBFBF),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
