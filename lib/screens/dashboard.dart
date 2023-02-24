import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_app/provider/tab_provider.dart';
import 'package:stock_app/screens/home.dart';
import 'package:stock_app/screens/notification.dart';
import 'package:stock_app/screens/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List screen = <Widget>[
    const NewHome(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TabProvider>(context);
    int index = provider.index;
    return Scaffold(
      body: screen[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0.0,
        iconSize: 30,
        currentIndex: index,
        onTap: (value) {
          provider.onTap(value);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
