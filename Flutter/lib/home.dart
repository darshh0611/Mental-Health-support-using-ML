import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:ipd/profile/profile.dart';
import 'package:ipd/questionnaire/questionnaire.dart';
import 'colors.dart';
import 'journal/journal.dart';
import 'feed/feed.dart';

class HomePage extends StatefulWidget {
  final String userId;

  const HomePage({required this.userId});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    FeedPage(),
    QuestionnairePage(),
    JournalPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: FlashyTabBar( // Use FlashyTabBar
        selectedIndex: _currentIndex,
        showElevation: false,
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
        }),
        backgroundColor: AppColors.white, // Set background color
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.home, color: AppColors.secondaryblue),
            title: Text('Feed', style: TextStyle(color: AppColors.secondaryblue)),
            ),
          FlashyTabBarItem(
            icon: Icon(Icons.emoji_emotions, color: AppColors.secondaryblue),
            title: Text('BlissBot', style: TextStyle(color: AppColors.secondaryblue)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.book, color: AppColors.secondaryblue),
            title: Text('Journalling', style: TextStyle(color: AppColors.secondaryblue)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.person, color: AppColors.secondaryblue),
            title: Text('Profile', style: TextStyle(color: AppColors.secondaryblue)),
          ),
        ],
      ),
    );
  }
}


class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 3 Content'),
    );
  }
}
