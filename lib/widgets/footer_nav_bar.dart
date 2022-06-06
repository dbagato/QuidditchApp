import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quidditch_app/theme/app_theme_global.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../services/services.dart';

class FooterNavBar extends StatefulWidget {
  FooterNavBar({Key? key}) : super(key: key);

  @override
  State<FooterNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<FooterNavBar> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.home, size: AppThemeGlobal.iconSize),
            Icon(Icons.play_arrow, size: AppThemeGlobal.iconSize),
            Icon(Icons.list, size: AppThemeGlobal.iconSize),
            Icon(Icons.settings, size: AppThemeGlobal.iconSize),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: AppThemeGlobal.primaryColor,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: AppThemeGlobal.primaryColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_page.toString(), textScaleFactor: 10.0),
                ElevatedButton(
                    onPressed: () => context.read<AuthCubit>().signOut(),
                    child: const Text("Logout"))
              ],
            ),
          ),
        ));
  }
}
