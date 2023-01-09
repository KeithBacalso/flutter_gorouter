import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/user_cubit.dart';
import '../router/route_utils.dart';
import 'favorites_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

//* RootPage is where the bottom nav pages are set up.
class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  late String _appbarTitle;

  @override
  Widget build(BuildContext context) {
    const bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Item'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ];

    if (_selectedIndex == 0) _appbarTitle = 'Nikki';
    if (_selectedIndex == 1) _appbarTitle = 'Favorites';
    if (_selectedIndex == 2) _appbarTitle = 'Profile';

    return Scaffold(
      appBar: AppBar(title: Text(_appbarTitle)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;

            //* === UNCOMMENT CODE TO TRY ===
            //* These 3 will not work if there path are not in GoRouter's routes.
            //* These 3 will still work in mobile if removed because there is setState() _selectedIndex.
            //* Web will still work if removed, but it is recommended because you can see the full path updating.
            if (_selectedIndex == 0) context.go(PAGE.home.path);
            if (_selectedIndex == 1) context.go(PAGE.favorites.path);
            if (_selectedIndex == 2) context.go(PAGE.profile.path);
          });
        },
        items: bottomNavBarItems,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [HomePage(), FavoritesPage(), ProfilePage()],
      ),
    );
  }
}
