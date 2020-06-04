import 'package:chatapplication/Services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();

  QuerySnapshot searchResultSnapshot;

  searchUser(){
    databaseMethods.getUserByName(searchTextEditingController.text)
        .then((result){
          setState(() {
            searchResultSnapshot = result;
          });
        });
  }

  createChatRoomStartConversation(String userName, currentUserName){

    List<String> users = [];
    //databaseMethods.createChatRoom(chatRoomId, chatRoomData)
  }

  Widget searchList(){
    return searchResultSnapshot != null ? ListView.builder(
      itemCount: searchResultSnapshot.documents.length,
      shrinkWrap: true,
      itemBuilder: (context, index){
        return SearchTile(
          userName: searchResultSnapshot.documents[index].data["name"],
          userEmail: searchResultSnapshot.documents[index].data["email"],
        );
      }) : Container();
  }

  @override
  void initState() {

    super.initState();
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
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
              height: 70.0,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2.0),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.only(left: 25.0),
                          child: TextField(
                            controller: searchTextEditingController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search a name"
                            ),
                          )
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      tooltip: 'Search',
                      onPressed: () {
                        searchUser();
                      },
                      splashColor: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(30.0),
                child: Center(
                    child: searchList(),
                ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {

  final String userName;
  final String userEmail;

  SearchTile({this.userName, this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                userName,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                userEmail,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.message),
            tooltip: 'Message',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

