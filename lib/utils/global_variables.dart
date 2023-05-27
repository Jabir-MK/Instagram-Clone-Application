import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/feeds_screen.dart';

const webScreenSize = 600;
const successMessage = 'SUCCESS';

const homeScreenItems = [
  FeedScreen(),
  Text('Search'),
  AddPostScreen(),
  Text('Notifications'),
  Text('Profile'),
];
