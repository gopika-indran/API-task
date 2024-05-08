import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:placement_api_task/models.dart';
import 'package:http/http.dart' as http;

class chatpage extends StatefulWidget {
  const chatpage({super.key});

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  Future<List<modeluser>> fetchdetails() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      List<modeluser> users =
          jsonData.map((json) => modeluser.fromJson(json)).toList();
      return users;
    } else {
      throw Exception("Failed to load details");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Conversations",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 249, 156, 187),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.pink,
                          ),
                          Text("Add Here")
                        ],
                      )),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search..."),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<modeluser>>(
                future: fetchdetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    List<modeluser>? users = snapshot.data;
                    return ListView.builder(
                      itemCount: users!.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            child: Text(user.id.toString()),
                          ),
                          title: Text(user.name),
                          subtitle: Text(user.email),
                          trailing: Text(user.website),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
