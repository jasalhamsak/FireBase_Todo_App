import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashview extends StatefulWidget {
  const Splashview({super.key});

  @override
  State<Splashview> createState() => _SplashviewState();
}

class _SplashviewState extends State<Splashview> {

  String?name;
  String?email;
  String?uid;
  String?token;

  getData()async{

    SharedPreferences _pref =await SharedPreferences.getInstance();
    token = await _pref.getString('token');
    name = await _pref.getString('name');
    email = await _pref.getString('email');
    uid = await _pref.getString('uid');


    setState(() {

    });

  }

  @override
  void initState() {
    getData();

    var d =Duration(seconds: 2);
    Future.delayed(d,(){
      checkLogginStatus();
    });


    super.initState();
  }


  Future<void>checkLogginStatus()async{
    if(token==null){
      Navigator.pushNamed(context, '/');
    }else{
      Navigator.pushNamed(context, '/home');
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("TODO-APP",style: TextStyle(color: Colors.white,fontSize: 30),),
      ),
    );
  }
}
