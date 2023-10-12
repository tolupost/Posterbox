import 'dart:convert';

class User {
  final String id;
  final String name;
  final String device;
  final String email;
  final String password;
  final String address;
  final String phone;
  final String token;
  final String image;
  final String verified;
  final String ongoing;
  final int wallet;
  final int deliveriesDone;
  final List<dynamic>? card;
  final List<dynamic> kyc;
  final List<dynamic>? schedule;
  final List<dynamic> notification;
  

  User( {
    required this.device,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.phone,
    required this.verified,
    required this.ongoing,
    required this.token,
    required this.card,
    required this.kyc,
    required this.wallet,
    required this.deliveriesDone,
    required this.image,
    required this.schedule,
    required this.notification,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'phone': phone,
      'verified': verified,
      'ongoing': ongoing,
      'deliveriesDone': deliveriesDone,
      'wallet': wallet,
      'token': token,
      'card': card,
      'image':image,
      'kyc': kyc,
      'schedule': schedule,
      'notification': notification,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      device:map['device']??'',
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      token: map['token'] ?? '',
      image: map['image'] ?? '',
      verified: map['verified'] ?? '',
      ongoing: map['ongoing'] ?? '',
      wallet: map['wallet'] ?? 0,
      deliveriesDone: map['deliveriesDone'] ?? 0,
      card: List<Map<String, dynamic>>.from(
        map['card'].map(
              (x) => Map<String, dynamic>.from(x),
        ),
      ),
      kyc: List<Map<String, dynamic>>.from(
        map['kyc']?.map(
              (x) => Map<String, dynamic>.from(x),
        ),
      ),
      schedule: List<Map<String, dynamic>>.from(
        map['schedule'].map(
              (x) => Map<String, dynamic>.from(x),
        ),
      ),
      notification: List<Map<String, dynamic>>.from(
        map['notification']?.map(
              (x) => Map<String, dynamic>.from(x),
        ),
      ),


    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? device,
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? phone,
    String? image,
    String? verified,
    String? ongoing,
    int? wallet,
    int? deliveriesDone,
    String? token,
    List<dynamic>? card,
    List<dynamic>? kyc,
    List<dynamic>? schedule,
    List<dynamic>? notification,
  }) {
    return User(
      device: device ?? this.device,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      token: token ?? this.token,
      card: card ?? this.card,
      verified: verified ?? this.verified,
      ongoing: ongoing ?? this.ongoing,
      image: image ?? this.image,
      kyc: kyc ?? this.kyc,
      wallet: wallet ?? this.wallet,
      schedule: schedule ?? this.schedule,
      notification: notification ?? this.notification, 
      deliveriesDone: deliveriesDone ?? this.deliveriesDone,
    );
  }
}