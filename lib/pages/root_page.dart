import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/user_cubit.dart';
import '../router/route_utils.dart';
import 'favorites_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

enum CurrentTab { home, favorites, profile }

//* RootPage is where the bottom nav pages are set up.
class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late String _appbarTitle;
  late CurrentTab currentTab = CurrentTab.home;
  late int currentTabIndex;

  @override
  void initState() {
    //* Do this when deeplinking without the use of redirect: of GoRouter
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   context.goNamed(PAGE.viewItem.name);
    // });
    currentTabIndex = currentTab.index;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Item'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ];

    if (currentTab == CurrentTab.home) _appbarTitle = 'Nikki';
    if (currentTab == CurrentTab.favorites) _appbarTitle = 'Favorites';
    if (currentTab == CurrentTab.profile) _appbarTitle = 'Profile';

    return Scaffold(
      appBar: AppBar(title: Text(_appbarTitle)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        onTap: (index) {
          setState(() {
            currentTabIndex = index;

            //* === UNCOMMENT CODE TO TRY ===
            //* These 3 will not work if there path are not in GoRouter's routes.
            //* These 3 will still work in mobile if removed because there is setState() _selectedIndex.
            //* Web will still work if removed, but it is recommended because you can see the full path updating.
            // if (currentTab == CurrentTab.home) context.go(PAGE.home.path);
            // if (currentTab == CurrentTab.favorites)
            //   context.go(PAGE.favorites.path);
            // if (currentTab == CurrentTab.profile) context.go(PAGE.profile.path);

            //* This code is refactored from the commented code above.
            context.go('/${CurrentTab.values[index].name}');
          });
        },
        items: bottomNavBarItems,
      ),
      body: IndexedStack(
        index: currentTabIndex,
        children: const [
          HomePage(),
          FavoritesPage(
            name: 'Nikki',
            gender: 'Female',
            age: 29,
          ),
          ProfilePage(),
        ],
      ),
    );
  }
}
