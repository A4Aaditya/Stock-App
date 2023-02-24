import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_app/models/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    fetchNotification();
  }

  List<NotificationModel> notifications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notication'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final buy = notification.quantity[0] == '+';
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: buy ? Colors.blue : Colors.red,
                child: buy
                    ? const Icon(
                        Icons.download,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.upload,
                        color: Colors.white,
                      ),
              ),
              title: Text(notification.productName),
            ),
          );
        },
      ),
    );
  }

  Future<void> fetchNotification() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final response = await FirebaseFirestore.instance
        .collection('notification')
        .where('user_id', isEqualTo: userId)
        .get();

    final docs = response.docs;
    final notificationsData = docs.map((e) {
      final json = e.data();
      return NotificationModel.fromMap(json);
    }).toList();
    setState(() {
      notifications = notificationsData;
    });
    log(notifications.toString());
  }
}
