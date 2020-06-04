import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  uploadUserInfo(userData){
    Firestore.instance.collection("Users")
        .add(userData);
  }

  getUserByName(String username) async{
    return await Firestore.instance.collection("Users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  createChatRoom(String chatRoomId, chatRoomData){
    Firestore.instance.collection("ChatRoom")
        .document(chatRoomId).setData(chatRoomData)
        .catchError((e){
          print(e.toString());
    });
  }
}