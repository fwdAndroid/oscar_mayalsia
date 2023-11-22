import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:oscar_mayalsia/database/database_methods.dart';
import 'package:oscar_mayalsia/screens/status/checkstatus.dart';

class MainAuth extends StatefulWidget {
  const MainAuth({Key? key}) : super(key: key);

  @override
  State<MainAuth> createState() => _MainAuthState();
}

class _MainAuthState extends State<MainAuth> {
  final formKey = GlobalKey<FormState>();
  int? isviewed;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                width: 150,
                height: 200,
              ),
              FlutterSocialButton(
                onTap: () async {
                  await DatabaseMethods().signInWithGoogle().then((value) => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => CheckStatus()))
                      });
                },
                buttonType:
                    ButtonType.google, // Button type for different type buttons
                iconColor: Colors.black, // for change icons colors
              ),
            ],
          ),
        ),
      ),
    );
  }
}
