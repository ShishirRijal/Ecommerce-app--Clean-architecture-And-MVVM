import 'package:flutter/material.dart';

import '../../core.dart/core.dart';
import 'home_page.dart';
import 'notifications_page.dart';
import 'search_page.dart';
import 'settings_page.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    NotificationsPage(),
    SettingsPage()
  ];
  List<String> titles = [
    AppString.home,
    AppString.search,
    AppString.notifications,
    AppString.settings,
  ];
  var _title = AppString.home;
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManager.lightGrey, spreadRadius: AppSize.s1)
        ]),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: AppString.home),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: AppString.search),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: AppString.notifications),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: AppString.settings),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
