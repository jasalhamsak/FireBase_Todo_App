import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/Resources/Models/User_model.dart';
import 'package:firebasedemo/Resources/services/auth-service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  UserModel _userModel = UserModel();
  AuthService _authService = AuthService();

  bool _isLoading = false;

  void _login() async{

    setState(() {
      _isLoading = true;
    });

    try{
      _userModel =UserModel(emial: _emailController.text,password: _passController.text);

      final data = await _authService.loginUser(_userModel);
      if (data != null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
              (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      List err =e.toString().split("]");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err[1])));
    }





  }

  final _loginKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Form(
              key: _loginKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Login To Your Account",
                      style: themedata.textTheme.displayMedium),
                  SizedBox(height: 20),
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
                      if (_loginKey.currentState!.validate()) {
                        _login();
                      }
                    },
                    child: Container(
                      width: 250,
                      height: 48,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text("Login",
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
                        "Don't have Account?",
                        style: themedata.textTheme.displaySmall,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            "Create Now",
                            style: themedata.textTheme.displayMedium,
                          ))
                    ],
                  )
                ],
              ),
            ),
            Visibility(
              visible: _isLoading,
                child: Center(
              child: CircularProgressIndicator(),
            ))
          ],
        ),
      ),
    );
  }

  // _login() async {
  //   UserCredential userData = await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(
  //           email: _emialController.text.trim(),
  //           password: _passController.text.trim());
  //   if (userData != null) {
  //     Navigator.pushNamedAndRemoveUntil(
  //       context,
  //       '/home',
  //       (route) => false,
  //     );
  //   }
  // }
}
