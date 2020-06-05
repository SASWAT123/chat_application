import 'package:chatapplication/Helper/constants.dart';
import 'package:chatapplication/Helper/helperFunctions.dart';
import 'package:chatapplication/Screens/conversation.dart';
import 'package:chatapplication/Screens/search.dart';
import 'package:chatapplication/Screens/signIn.dart';
import 'package:chatapplication/Services/auth.dart';
import 'package:chatapplication/Services/database.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  signOut(){
    authMethods.signOut()
      .then((result){
        HelperFunctions.saveUserLoggedInSharedPreference(false);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => SignIn()
        ));
      });

  }

  Stream chatRoomStream;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ChatRoomsTile(
                userName: snapshot.data.documents[index].data['chatRoomId']
                    .toString()
                    .replaceAll(Constants.currentUserName, ""),
                chatRoomId: snapshot.data.documents[index].data["chatRoomId"],
              );
            })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    DatabaseMethods().getChatRooms(Constants.currentUserName).then((snapshots) {
      setState(() {
        chatRoomStream = snapshots;
      });
    });
  }

  getUserInfo() async{
    Constants.currentUserName = await HelperFunctions.getUserNameSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dev Connect",
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            tooltip: 'Signout',
            onPressed: () {
              signOut();
            },
          ),
        ],
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: chatRoomsList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName,@required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ConversationScreen(
              chatRoomId,
            )
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.white,
              style: BorderStyle.solid,
              width: 3.0),
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(30)),
              child: Text(userName.substring(0, 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
