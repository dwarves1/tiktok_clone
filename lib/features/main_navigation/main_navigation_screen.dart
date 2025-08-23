import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final screens = [
    Center(child: Text("Home")),
    Center(child: Text("Search")),
    Center(child: Text("Home")),
    Center(child: Text("Home")),
    Center(child: Text("Home")),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        selectedItemColor: Theme.of(context).primaryColor,
        // type으로 fixed, shifting 설정 가능
        type: BottomNavigationBarType.shifting,
        // item이 4개 이상이면 shifting
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: "Home",
            tooltip: "What are you?",
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: "Search",
            // 길게 누르고 있으면 나오는 툴팁
            tooltip: "What are you?",
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
