import 'package:carbon_quiz_app/Views/leaderboard.dart';
import 'package:carbon_quiz_app/Views/profile_screen.dart';
import 'package:carbon_quiz_app/Views/quiz_screen.dart';
import 'package:flutter/material.dart';

class NavbarCatSelection extends StatefulWidget {
  final int initialIndex;
  const NavbarCatSelection({super.key, this.initialIndex = 1});

  @override
  State<NavbarCatSelection> createState() => _NavbarCatSelectionState();
}

class _NavbarCatSelectionState extends State<NavbarCatSelection> {
  final PageStorageBucket bucket = PageStorageBucket();
  final pages = [
    const QuizScreen(),
    const Leaderboard(),
    const ProfileScreen(),
  ];

  late int selectedIndex;
  @override
  void initState() {
    selectedIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket, 
        child: pages[selectedIndex]
        ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState (() {
            selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Question'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'
          ),
        ]
      ),
      appBar: AppBar(backgroundColor: Colors.blue, )
    );
  }
}