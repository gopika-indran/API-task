import 'package:flutter/material.dart';
import 'package:placement_api_task/channel.dart';
import 'package:placement_api_task/chatpage.dart';
import 'package:placement_api_task/profile.dart';

class bottompage extends StatefulWidget {
  const bottompage({super.key});

  @override
  State<bottompage> createState() => _bottompageState();
}

class _bottompageState extends State<bottompage> {
  int myindex = 0;
  List pages = [const chatpage(), const channelpage(), const profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myindex = index;
          });
        },
        currentIndex: myindex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "chat"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "channel"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile")
        ],
      ),
      body: pages[myindex],
    );
  }
}
