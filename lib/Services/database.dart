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

  getUserByEmail(String userEmail) async{
    return await Firestore.instance.collection("Users")
        .where("email", isEqualTo: userEmail)
        .getDocuments();
  }

  createChatRoom(String chatRoomId, chatRoomData){
    Firestore.instance.collection("ChatRoom")
        .document(chatRoomId).setData(chatRoomData)
        .catchError((e){
          print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap){
    Firestore.instance.collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e){
          print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async{
    return await Firestore.instance.collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  getChatRooms(String currentUserName) async {
    return await Firestore.instance
        .collection("ChatRoom")
        .where('users', arrayContains: currentUserName)
        .snapshots();
  }
}