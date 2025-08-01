import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/Resources/Models/User_model.dart';
import 'package:firebasedemo/Resources/services/auth-service.dart';
import 'package:flutter/material.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  UserModel _userModel = UserModel();
  AuthService _authService = AuthService();

  bool _isLodding = false;

  void _register() async {
    setState(() {
      _isLodding = true;
    });

    _userModel = UserModel(
        emial: _emailController.text,
        password: _passController.text,
        name: _nameController.text,
        status: 1,
        createdAt: DateTime.now());

    try {
      await Future.delayed(Duration(seconds: 3));
      final userData =await _authService.registerUser(_userModel);

      if (userData != null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLodding = false;
      });
      List err =e.toString().split("]");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err[1])));
    }
  }

  final _regKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Form(
              key: _regKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Create an Account",
                      style: themedata.textTheme.displayMedium),
                  SizedBox(height: 20),
                  TextFormField(
                    style: themedata.textTheme.displaySmall,
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a Name";
                      }
                    },
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                        hintText: "Enter Name",
                        hintStyle: themedata.textTheme.displaySmall,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: themedata.textTheme.displaySmall,
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter an Email Id";
                      }
                    },
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                        hintText: "Enter Email",
                        hintStyle: themedata.textTheme.displaySmall,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: themedata.textTheme.displaySmall,
                    controller: _passController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter password";
                      }
                    },
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                        hintText: "Enter Password",
                        hintStyle: themedata.textTheme.displaySmall,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_regKey.currentState!.validate()) {



                        _register();



                        // UserCredential userDate = await FirebaseAuth.instance
                        //     .createUserWithEmailAndPassword(
                        //         email: _emialController.text.trim(),
                        //         password: _passController.text.trim());
                        // if (userDate != null) {
                        //   FirebaseFirestore.instance
                        //       .collection('users')
                        //       .doc(userDate.user!.uid)
                        //       .set({
                        //     'uid': userDate.user!.uid,
                        //     'email': userDate.user!.email,
                        //     'name': _nameController.text.trim(),
                        //     'createdAt': DateTime.now(),
                        //     'status': 1
                        //   }).then(
                        //     (value) => Navigator.pushNamedAndRemoveUntil(
                        //       context,
                        //       '/home',
                        //       (route) => false,
                        //     ),
                        //   );
                        // }
                      }
                    },
                    child: Container(
                      width: 250,
                      height: 48,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text("Create an Account",
                              style: themedata.textTheme.displayMedium)),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have Account?",
                        style: themedata.textTheme.displaySmall,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            "Login Now",
                            style: themedata.textTheme.displayMedium,
                          ))
                    ],
                  )
                ],
              ),
            ),
            Visibility(
                visible: _isLodding,
                child: Center(
                  child: CircularProgressIndicator(),
                ))
          ],
        ),
      ),
    );
  }
}
