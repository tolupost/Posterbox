// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Delivery {
  final String username;
  final String userId;
  final String deliverId;
  final String deliveryfee;
  final String deliverydate;
  final String state1;
  final String state2;
  final String deliveryinstructions;
  final String deliveryweight;
  final String deliverytimeline;
  final String recevieraddress;
  final String receviername;
  final String receviernumber;
  final String sendername;
  final String sendernumber;
  final String senderaddress;
  final String progress;
  final String usernumber;
  final int start;
  final int end;
  final String? id;
  final bool wallet;
  final String senderusername;
  Delivery(
      {
        required this.userId,
        required this.deliverId, 
        required this.deliverydate,
      required this.wallet,
      required this.username,
      required this.state1,
      required this.state2,
      required this.deliveryfee,
      required this.deliveryinstructions,
      required this.deliveryweight,
      required this.deliverytimeline,
      required this.recevieraddress,
      required this.receviername,
      required this.receviernumber,
      required this.sendername,
      required this.sendernumber,
      required this.senderaddress,
      required this.progress,
      required this.usernumber,
        required this.start,
        required this.end,
       required this.senderusername,
      this.id
      });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'userId':userId, 
      'deliverId':deliverId, 
      'senderusername': senderusername,
      'deliveryfee': deliveryfee,
      'deliverydate': deliverydate,
      'deliveryinstructions': deliveryinstructions,
      'deliveryweight': deliveryweight,
      'deliverytimeline': deliverytimeline,
      'recevieraddress': recevieraddress,
      'receviername': receviername,
      'receviernumber': receviernumber,
      'sendername': sendername,
      'sendernumber': sendernumber,
      'senderaddress': senderaddress,
      'wallet': wallet,
      'progress': progress,
      'usernumber': usernumber,
      'id': id,
      'state1':state1,
      'state2':state2,
      'start':start,
      'end':end
    };
  }

  factory Delivery.fromMap(Map<String, dynamic> map) {
    return Delivery(
      username: map['username'] ?? '',
      deliveryfee: map['deliveryfee'] ?? '',
      deliverydate: map['deliverydate'] ?? '',
      deliveryinstructions: map['deliveryinstructions'] ?? '',
      deliveryweight: map['deliveryweight'] ?? '',
      deliverytimeline: map['deliverytimeline'] ?? '',
      recevieraddress: map['recevieraddress'] ?? '',
      receviername: map['receviername'] ?? '',
      receviernumber: map['receviernumber'] ?? '',
      sendername: map['sendername'] ?? '',
      sendernumber: map['sendernumber'] ?? '',
      senderaddress: map['senderaddress'] ?? '',
      progress: map['progress'] ?? '',
      usernumber: map['usernumber'] ?? '',
      senderusername: map['senderusername'] ?? '',
      id: map['_id'] ?? '',
      state1: map['state1'] ?? '',
        state2: map['state2'] ?? '',
        start: map['start'] ?? '',
        end: map['end'] ?? '', 
        wallet:  map['wallet'] ?? '', 
        deliverId: map['deliverId']??'', 
        userId: map['userId']??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory Delivery.fromJson(String source) =>
      Delivery.fromMap(json.decode(source));
}
