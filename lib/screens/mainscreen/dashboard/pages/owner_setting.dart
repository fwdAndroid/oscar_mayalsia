import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:oscar_mayalsia/screens/auth/main_auth.dart';
import 'package:oscar_mayalsia/screens/mainscreen/dashboard/pages/order_history.dart';

class OwnerSetting extends StatefulWidget {
  const OwnerSetting({super.key});

  @override
  State<OwnerSetting> createState() => _OwnerSettingState();
}

class _OwnerSettingState extends State<OwnerSetting> {
  zisttile(String text, IconData icon, VoidCallback function) {
    return ListTile(
        onTap: function,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.1),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Colors.blue,
            ),
          ),
        ),
        title: Text(
          text,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
        ),
        trailing: IconButton(
          onPressed: function,
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Three Star Trading"),
      ),
      body: Column(
        children: [
          zisttile('Notifications', Icons.notifications, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => OrderHistory()));
          }),
          Divider(
            color: Colors.grey,
            thickness: 0.5,
            indent: 15,
            endIndent: 15,
          ),
          zisttile('Orders', Icons.online_prediction_rounded, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => OrderHistory()));
          }),
          Divider(
            color: Colors.grey,
            thickness: 0.5,
            indent: 15,
            endIndent: 15,
          ),
          zisttile('Logout', Icons.logout, () {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                        title: const Text('Log Out Alert'),
                        content: const Text(
                            'Are You Sure To Logout From This account'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              FirebaseAuth.instance.signOut().then((value) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => MainAuth()));
                              });
                            },
                            child: const Text('OK'),
                          ),
                        ]));
          })
        ],
      ),
    );
  }
}
