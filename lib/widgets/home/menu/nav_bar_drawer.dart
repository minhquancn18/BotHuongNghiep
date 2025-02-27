// ignore_for_file: prefer_const_constructors, avoid_returning_null_for_void, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/menu/admin_manage_screen.dart';
import 'package:huong_nghiep/screens/menu/favorite_screen.dart';
import 'package:huong_nghiep/screens/menu/jobs_manage_screen.dart';
import 'package:huong_nghiep/screens/menu/news_manage_screen.dart';
import 'package:huong_nghiep/screens/menu/profile_screen.dart';
// import 'package:huong_nghiep/screens/menu/police_screen.dart';
// import 'package:huong_nghiep/screens/menu/setting_screen.dart';
import 'package:huong_nghiep/screens/menu/question_solution_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/home/home_provider.dart';

class NavBarDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            onTap: () => Get.to(ProfileScreen()),
            child: UserAccountsDrawerHeader(
              accountName: Text(homeProvider.user.name),
              accountEmail: Text(homeProvider.user.email),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    homeProvider.user.image,
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Yêu thích'),
            onTap: () => Get.to(FavoriteScreen()),
          ),
          homeProvider.user.isAdmin
              ? ListTile(
                  leading: Icon(Icons.account_box_outlined),
                  title: Text('Quản lý tài khoản'),
                  onTap: () => Get.to(AdminManageScreen()))
              : SizedBox(),
          homeProvider.user.isAdmin
              ? ListTile(
                  leading: Icon(MdiIcons.postOutline),
                  title: Text('Quản lý bài đăng'),
                  onTap: () => Get.to(JobsManageScreen()),
                )
              : SizedBox(),
          homeProvider.user.isAdmin
              ? ListTile(
                  leading: Icon(MdiIcons.newspaperVariantOutline),
                  title: Text('Quản lý tin tức'),
                  onTap: () => Get.to(NewsManageScreen()),
                )
              : SizedBox(),
          homeProvider.user.isAdmin
              ? ListTile(
                  leading: Icon(Icons.question_answer_outlined),
                  title: Text('Trả lời câu hỏi'),
                  onTap: () => Get.to(QuestionSolutionScreen()),
                )
              : SizedBox(),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Cài đặt'),
          //   onTap: () => Get.to(SettingScreen()),
          // ),
          // ListTile(
          //   leading: Icon(Icons.description),
          //   title: Text('Chính sách ứng dụng'),
          //   onTap: () => Get.to(PoliceScreen()),
          // ),
          Divider(),
          ListTile(
            title: Text('Đăng xuất'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => homeProvider.signOut(),
          ),
        ],
      ),
    );
  }
}
