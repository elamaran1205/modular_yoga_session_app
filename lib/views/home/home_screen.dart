import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga2/controllers/navigation_controller.dart';
import 'daily_routine.dart';
import 'all_yoga.dart';
import 'streak.dart';
import 'profile.dart';

class HomeScreen extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: _buildDrawer(),
      body: Obx(() => _getCurrentPage()),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            child:Center(child: Text('Menu', style: TextStyle(color: Colors.amber, fontSize: 24))),),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _getCurrentPage() {
    switch (navController.currentIndex.value) {
      case 0: return DailyRoutine();
      case 1: return AllYoga();
      case 2: return Streak();
      case 3: return Profile();
      default: return DailyRoutine();
    }
  }

  Widget _buildBottomNavBar() {
  return Obx(
    () => Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          currentIndex: navController.currentIndex.value,
          onTap: navController.changePage,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.white70,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            _buildNavItem(Icons.calendar_today, 'Daily'),
            _buildNavItem(Icons.fitness_center, 'Yoga'),
            _buildNavItem(Icons.local_fire_department, 'Streak'),
            _buildNavItem(Icons.person, 'Profile'),
          ],
        ),
      ),
    ),
  );
}

BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
  return BottomNavigationBarItem(
    icon: Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Icon(icon, size: 20),
    ),
    activeIcon: Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.amber, width: 2)),
      ),
      child: Icon(icon, size: 14, color: Colors.amber),
    ),
    label: label,
  );
}
}