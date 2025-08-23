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

      bottomNavigationBar: NavigationBar(
        // 아이콘 라벨 보여주는 방식 설정
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _selectedIndex,
        // onTap == onDestinationSelected
        onDestinationSelected: _onTap,
        // items == destinations
        destinations: [
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.house, color: Colors.teal),
            label: "Home",
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass, color: Colors.amber),
            label: "Search",
          ),
        ],
      ),
    );
  }
}
