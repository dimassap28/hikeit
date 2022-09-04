import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hike_it/content/dashboard_content.dart';
import 'package:hike_it/content/favourite_content.dart';
import 'package:hike_it/content/header.dart';
import 'package:hike_it/content/order_content.dart';

import 'package:hike_it/content/profile_content.dart';
import 'package:hike_it/controllers/order_controllers.dart';
import 'package:hike_it/controllers/places_controllers.dart';
import 'package:hike_it/controllers/users_controller.dart';
import 'package:hike_it/session_helper.dart';
// import 'package:hike_it/content/selection_content.dart';
import 'package:hike_it/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  bool isPendaki = true;
  // static List<Widget> _widgetOptions =

  @override
  void initState() {
    Get.put(OrderController());
    Get.put(PlacesController());
    Get.put(UsersController());
    cekRoleUser();
    super.initState();
  }

  void cekRoleUser() async {
    var res = await SessionHelper.isPendaki();
    log('aku adalah pendaki? $res');
    setState(() {
      isPendaki = res;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                _selectedIndex != 3 //(isPendaki ? 2 : 3)
                    ? const Header()
                    : const SizedBox(),
                Expanded(
                  child: <Widget>[
                    const DashboardContent(),
                    const FavouriteContent(),
                    // if (!isPendaki)
                    const OrderContent(),
                    // SelectionContent(),
                    const ProfileContent(),
                  ].elementAt(_selectedIndex),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          // elevation: 0,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? SvgPicture.asset(
                      "assets/icons/dashboard/Dashboard.svg",
                      // color: abuAbu,
                    )
                  : SvgPicture.asset(
                      "assets/icons/dashboard/Dashboard.svg",
                      color: abuAbu,
                      height: getHeight(20),
                    ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? SvgPicture.asset(
                      "assets/icons/dashboard/Bookmark.svg",
                      // color: abuAbu,
                    )
                  : SvgPicture.asset(
                      "assets/icons/dashboard/Bookmark.svg",
                      color: abuAbu,
                      height: getHeight(20),
                    ),
              label: 'Favourite',
            ),
            // if (!isPendaki)
            BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? SvgPicture.asset(
                      "assets/icons/dashboard/Document.svg",
                      // color: abuAbu,
                    )
                  : SvgPicture.asset(
                      "assets/icons/dashboard/Document.svg",
                      color: abuAbu,
                      height: getHeight(20),
                    ),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 3
                  ? SvgPicture.asset(
                      "assets/icons/dashboard/Profile.svg",
                      // color: abuAbu,
                    )
                  : SvgPicture.asset(
                      "assets/icons/dashboard/Profile.svg",
                      color: abuAbu,
                      height: getHeight(20),
                    ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: ungu,
          selectedFontSize: 12,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
