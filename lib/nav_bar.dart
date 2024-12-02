import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myapp/presentation/page/home_page.dart';
import 'package:myapp/presentation/page/borrowed_page.dart';
import 'package:myapp/presentation/page/profile_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int counter = 0;

  List<Widget> pages = [
    const HomePage(),
    const BorrowedPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(Icons.book, size: 30),
          Icon(Icons.library_books, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (value) => setState(() {
          counter = value;
        }),
      ),
      body: pages[counter],
    );
  }
}
