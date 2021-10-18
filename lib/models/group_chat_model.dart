import 'package:cloud_firestore/cloud_firestore.dart';

class GroupChatModel {
  final String message;
  final String senderName;
  final String senderUserId;
  final dynamic date;
  GroupChatModel({this.message, this.senderName, this.senderUserId, this.date});

  GroupChatModel.fromMap(Map<String, Object> map):this(
    message: map["message"] as String,
    senderName: map["senderName"] as String,
    senderUserId: map["senderUserId"] as String,
    date: map["date"] as Timestamp
  );

  Map<String, Object> toJson(){
    return {
      "message": message,
      "senderName": senderName,
      "senderUserId": senderUserId,
      "date": date
    };
  }
}