import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oscar_mayalsia/screens/mainscreen/dashboard/main_dashborad.dart';
import 'package:oscar_mayalsia/widgets/textfieldwidget.dart';

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
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passController = TextEditingController();
    bool _isLoading = false;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/logo.png",
                  width: 150,
                  height: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormInputField(
                  controller: _emailController,
                  hintText: "Enter Email",
                  textInputType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormInputField(
                  controller: _passController,
                  hintText: "Enter Password",
                  textInputType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 24),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passController.text);
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => MainDashboard()));
                      },
                      child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
