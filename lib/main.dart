import 'package:chatapplication/Helper/helperFunctions.dart';
import 'package:chatapplication/Screens/chatRoom.dart';
import 'package:flutter/material.dart';
import 'Screens/signIn.dart';
import 'Screens/signUp.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;

  getLoggedInState()async{
    await HelperFunctions.getUserLoggedInSharedPreference().then((result){
      setState(() {
        userIsLoggedIn  = result;
      });
    });
  }

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage()
      },
      home: userIsLoggedIn != null ?  userIsLoggedIn ? ChatRoom() : SignIn(): Container(
        child: Center(
          child: SignIn(),
        ),
      ),
    );
  }
}

