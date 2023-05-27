// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Image.asset(
          'assets/insta_logo.png',
          color: primaryColor,
          height: 64,
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              log('Messages');
            },
            icon: const FaIcon(FontAwesomeIcons.facebookMessenger),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 10),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 5),
                child: index == 0
                    ? InkWell(
                        onTap: () {
                          log('Add stories');
                        },
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.red,
                                    blueColor,
                                    Colors.green,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1611787640592-ebf78080d96e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aG9ycm9yJTIwc2NlbmV8ZW58MHx8MHx8fDA%3D&w=1000&q=80'),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              left: 45,
                              child: CircleAvatar(
                                backgroundColor: blueColor,
                                radius: 8,
                                child: Icon(
                                  Icons.add_rounded,
                                  size: 15,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.red,
                              blueColor,
                              Colors.green,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              'https://images.pexels.com/photos/1839564/pexels-photo-1839564.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                        ),
                      ),
              ),
              itemCount: 8,
            ),
          ),
          const Divider(thickness: 1),
          const PostCard(),
        ],
      ),
    );
  }
}
