import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_app/provider/theme_provider.dart';
import 'package:profile/profile.dart';
import 'package:stock_app/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    const url =
        'https://images.freeimages.com/images/large-previews/d41/bear-combat-2-1332988.jpg';
    const name = 'Aditya Kumar Singh';
    const website = 'wwww.A4Aditya.in';
    const designation = 'Flutter Developer';
    const email = 'aditya@gmail.com';
    const phoneNumber = '1234567890';
    final provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: provider.isDarkMode ? Colors.grey : Colors.cyan,
              ),
              child: Center(
                child: Profile(
                  imageUrl: url,
                  name: name,
                  website: website,
                  designation: designation,
                  email: email,
                  phone_number: phoneNumber,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SwitchListTile(
                          onChanged: (value) {
                            provider.isDarkMode = value;
                            provider.toggleTheme();
                          },
                          value: provider.isDarkMode,
                          title: provider.isDarkMode
                              ? const Text('Switch to Light Mode')
                              : const Text('Switch to Dark Mode'),
                          secondary: const Icon(Icons.dark_mode),
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Logout'),
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            final route = MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            );
                            Navigator.pushAndRemoveUntil(
                                context, route, (route) => false);
                            // Logout code
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
