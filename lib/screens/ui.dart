// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class UI extends StatelessWidget {
  const UI({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 55,
                        margin: const EdgeInsets.only(left: 10),
                        width: 55,
                        decoration: const BoxDecoration(
                          border: Border(),
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                //
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                //
                Container(
                  decoration: BoxDecoration(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(backgroundColor: Colors.grey),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text('data'),
                                  Text('data'),
                                ],
                              ),
                              Spacer(),
                              Icon(Icons.more_horiz)
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 400,
                          child: Image.network(
                            'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80',
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                Expanded(child: Container())
              ],
            ),
          ),
          bottomNavigationBar: NavigationBar(
            backgroundColor: mobileSearchColor,
            height: 50,
            destinations: const [
              Icon(Icons.home),
              Icon(Icons.search),
              Icon(Icons.add),
              Icon(Icons.favorite_outline),
              Icon(Icons.person_outline),
            ],
          )
          // BottomNavigationBar(items: [
          //   BottomNavigationBarItem(icon: Icon(Icons.home)),
          //   BottomNavigationBarItem(icon: Icon(Icons.search)),
          // ]),
          ),
    );
  }
}
