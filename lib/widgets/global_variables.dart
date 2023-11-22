// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:instagram/screens/add_post_screen.dart';
// import 'package:instagram/screens/feed_screen.dart';
// import 'package:instagram/screens/profile_screen.dart';
// import 'package:instagram/screens/search_screen.dart';

import 'package:flutter/material.dart';
import 'package:oscar_mayalsia/screens/mainscreen/dashboard/pages/order_history.dart';
import 'package:oscar_mayalsia/screens/mainscreen/dashboard/pages/owner_chat.dart';
import 'package:oscar_mayalsia/screens/mainscreen/dashboard/pages/owner_setting.dart';
import 'package:oscar_mayalsia/screens/mainscreen/dashboard/pages/home_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  Home_Screen(),
  OrderHistory(),
  OwnerChat(),
  OwnerSetting(),

  // Profile()
  //  Random(),
  //  ChatPage(),
  //  Profile(),
];
