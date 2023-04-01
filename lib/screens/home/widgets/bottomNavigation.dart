import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moneymanagementapp/screens/home/screen_home.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndex,
      builder: ((BuildContext ctx,int updatedIndex, Widget? _) {
        return BottomNavigationBar(
          currentIndex: updatedIndex,
          selectedItemColor: Colors.red,
          showUnselectedLabels: false,
          selectedFontSize: 18,
          unselectedItemColor: Colors.indigo,
          onTap: (newIndex) {
          ScreenHome.selectedIndex.value = newIndex;
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.monetization_on), label: 'Transactions'),
        ],
        );
      }), 
    );
  }
}
